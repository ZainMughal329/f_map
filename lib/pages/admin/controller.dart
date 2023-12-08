import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/models/location_model.dart';
import 'package:f_map/pages/admin/index.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AdminController extends GetxController {
  final state = AdminState();

  @override
  void onInit() {
    // TODO: implement onInit
    _initMap();
    // getUpdatedCurrentLocation();
    showMarkersList();

    goToCurrentLocation();
    getVisibleMarkers();
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

  // getUpdatedCurrentLocation() async {
  //   _location.onLocationChanged.listen((LocationData locationData) async {
  //     state.currentLocation.value = LatLng(locationData.latitude!.toDouble(),
  //         locationData.longitude!.toDouble());
  //     state.speed = locationData.speed! * 3.6;
  //     update();
  //     await FirebaseFirestore.instance
  //         .collection('location')
  //         .doc(FirebaseAuth.instance.currentUser!.uid.toString())
  //         .update({
  //       'lat': locationData.latitude!.toDouble(),
  //       'lang': locationData.longitude!.toDouble(),
  //       'speed': state.speed,
  //     }).then((value) {
  //       goToCurrentLocation();
  //       print('before');
  //       print('speed val : ' + state.speed.toString());
  //
  //       showMarkersList();
  //       getVisibleMarkers();
  //
  //       print('new location fetched');
  //     }).onError((error, stackTrace) {
  //       print('failed');
  //     });
  //   });
  // }

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
    final snap = await FirebaseFirestore.instance.collection('location').get();
    print('len:' + snap.docs.length.toString());

    if (snap.docs.isNotEmpty) {
      state.markerList.clear();
      for (var mar in snap.docs) {
        print("markerId123" + mar.id.toString());

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
          infoWindow: InfoWindow(
            title: mar['vehicleNum'],

          )
        );

        state.markerList.add(marker);
      }

      getVisibleMarkers();
    }
  }

  List<Marker> getVisibleMarkers() {
    visibleMarkers.clear();
    for (var marker in state.markerList) {
        visibleMarkers.add(marker);
    }
    print('visibleMarkers length : ' + visibleMarkers.length.toString());
    print(visibleMarkers.toString());
    return visibleMarkers;
  }




}
