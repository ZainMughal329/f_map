import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/models/location_model.dart';
import 'package:f_map/pages/map_screen/index.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
    super.onInit();
  }

  Future<void> _initMap() async {
    await goToCurrentLocation();
  }

  GoogleMapController? mapController;
  Location _location = Location();
  List<Marker> visibleMarkers = [];

  getUpdatedCurrentLocation() async {
    _location.onLocationChanged.listen((LocationData locationData) async {

      state.currentLocation.value = LatLng(locationData.latitude!.toDouble(),
          locationData.longitude!.toDouble());
      await FirebaseFirestore.instance
          .collection('location')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .update({
        'lat': locationData.latitude!.toDouble(),
        'lang': locationData.longitude!.toDouble()
      }).then((value) {
        goToCurrentLocation();
        print('before');
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
        print("markerId123"+mar.id.toString());
        // print('lat:' + mar['lat'].toString());
        // print('lang:' + mar['lang'].toString());

        final lat = mar['lat'] as double?;
        final lng = mar['lang'] as double?;
        var marker = Marker(
          markerId: MarkerId(mar.id.toString()),
          position: LatLng(lat!, lng!),
        );
        state.markerList.add(marker);
        // print(state.markerList.toString());
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
