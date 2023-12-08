import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/models/location_model.dart';
import 'package:f_map/pages/map_screen/index.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  final state = MapState();

  @override
  void onInit() {
    // TODO: implement onInit
    _initMap();
    getUpdatedCurrentLocation();
    showMarkersList();
    calculateDistancesBetweenMarkers();
    super.onInit();
  }

  Future<void> _initMap() async {
    await goToCurrentLocation();
  }

  GoogleMapController? mapController;
  Location _location = Location();
  List<Marker> visibleMarkers = [];

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  getUpdatedCurrentLocation() async {
    _location.onLocationChanged.listen((LocationData locationData) async {
      state.currentLocation.value = LatLng(locationData.latitude!.toDouble(),
          locationData.longitude!.toDouble());
      state.speed = locationData.speed! * 3.6;
      update();
      await FirebaseFirestore.instance
          .collection('location')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .update({
        'lat': locationData.latitude!.toDouble(),
        'lang': locationData.longitude!.toDouble(),
        'speed': state.speed,
      }).then((value) {
        goToCurrentLocation();
        print('before');
        print('speed val : ' + state.speed.toString());

        showMarkersList();
        getVisibleMarkers();

        print('new location fetched');
      }).onError((error, stackTrace) {
        print('failed');
      });
    });
  }

  Future<void> checkLocationPermission() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> goToCurrentLocation() async {
    LocationData locationData = await _location.getLocation();
    if (mapController != null) {
      state.currentLocation.value = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
      // CameraPosition currentCameraPosition = await mapController!.
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            // target: LatLng(
            //   locationData.latitude!,
            //   locationData.longitude!,
            // ),
            target: state.currentLocation.value,
            zoom: 20.0,
            // bearing: 0, // Set the initial bearing
            tilt: 45.0,
          ),
        ),
      );
    }
  }

  showMarkersList() async {
    // state.markerList.clear();
    final snap = await FirebaseFirestore.instance.collection('location').get();
    // print((state.markerList..toString()));
    print('len:' + snap.docs.length.toString());

    if (snap.docs.isNotEmpty) {
      //adsfsadfasdf
      state.markerList.clear();
      for (var mar in snap.docs) {
        print("markerId123" + mar.id.toString());
        // print('lat:' + mar['lat'].toString());
        // print('lang:' + mar['lang'].toString());

        final Uint8List markerIcon;
        if (mar['vehicleType'] == 'Car') {
          markerIcon = await getBytesFromAssets('assets/images/car.png', 50);
        } else if (mar['vehicleType'] == 'Bus') {
          markerIcon = await getBytesFromAssets('assets/images/bus.png', 50);
        } else if (mar['vehicleType'] == 'Bike') {
          markerIcon =
              await getBytesFromAssets('assets/images/bycicle.png', 50);
        } else {
          markerIcon = await getBytesFromAssets('assets/images/walk.png', 50);
        }
        final lat = mar['lat'] as double?;
        final lng = mar['lang'] as double?;
        var marker = Marker(
          markerId: MarkerId(mar.id.toString()),
          position: LatLng(lat!, lng!),
          icon: BitmapDescriptor.fromBytes(markerIcon),
        );

        state.markerList.add(marker);
        // print(state.markerList.toString());
      }

      getVisibleMarkers();
    }
  }

  List<Marker> getVisibleMarkers() {
    const double maxDistance = 1000; // Maximum distance in meters

    visibleMarkers.clear();
    for (var marker in state.markerList) {
      double distance = calculateDistance(state.currentLocation.value, marker.position);
      if (distance <= maxDistance) {
        visibleMarkers.add(marker);
      }
    }
    print('visibleMarkers length : ' + visibleMarkers.length.toString());
    print(visibleMarkers.toString());
    return visibleMarkers;
  }

  // Calculating distance between markers on map
  void calculateDistancesBetweenMarkers() {
    List<Marker> visibleMarkers = getVisibleMarkers();
    print('length is : ' + visibleMarkers.length.toString());
    for (var marker in visibleMarkers) {
      double distance = calculateDistance(state.currentLocation.value, marker.position);
      print('Distance to ${marker.markerId.value}: $distance meters');
    }
  }



  // method for calculating distance using mathematical equations
  double calculateDistance(LatLng start, LatLng end) {
    const int earthRadius = 6371000; // in meters
    double lat1 = degreesToRadians(start.latitude);
    double lon1 = degreesToRadians(start.longitude);
    double lat2 = degreesToRadians(end.latitude);
    double lon2 = degreesToRadians(end.longitude);

    double dLon = lon2 - lon1;
    double dLat = lat2 - lat1;

    double a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dLon / 2), 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  // Convert the map coordinates(latitude and longitude) that are in degree to radian.
  double degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }


  deleteCurrentNode() async {
    await FirebaseFirestore.instance
        .collection('location')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete()
        .then((value) {
      print('deleted');
    }).onError((error, stackTrace) {
      print('error');
    });
  }
}
