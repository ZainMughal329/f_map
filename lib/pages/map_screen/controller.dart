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


  getUpdatedCurrentLocation() async {
    _location.onLocationChanged.listen((LocationData locationData) async {
      state.currentLocation.value = LatLng(locationData.latitude!.toDouble(),
          locationData.longitude!.toDouble());
      await FirebaseFirestore.instance.collection('location').doc(
          FirebaseAuth.instance.currentUser!.uid.toString()).set(
          LocationModel(
              id: FirebaseAuth.instance.currentUser!.uid.toString(),
              userName: 'userName',
              vehicleType: 'vehicleType',
              vehicleNum: 'vehicleNum',
              lat: locationData.latitude!.toDouble(),
              lang: locationData.longitude!.toDouble()).toJson(),
      ).then((value) {
        print('before');
        showMarkersList();
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
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              locationData.latitude!,
              locationData.longitude!,
            ),
            zoom: 15.0,
          ),
        ),
      );
    }
  }

  showMarkersList() async {
    final snap = await FirebaseFirestore.instance.collection('location').get();
    print('len:'+snap.docs.length.toString());
    if(snap.docs.isNotEmpty) {
      for(var mar in snap.docs) {
        print('lat:' + mar['lat'].toString());
        print('lang:' + mar['lang'].toString());

        final lat = mar['lat'] as double?;
        final lng = mar['lang'] as double?;
        var marker = Marker(
          markerId: MarkerId(FirebaseAuth.instance.currentUser!.uid.toString()),
          position: LatLng(lat!, lng!),
        );
        state.markerList.add(marker);
      }
    }
  }

  List<Marker> getVisibleMarkers() {
    List<Marker> visibleMarkers = [];

    for (var marker in state.markerList) {
        visibleMarkers.add(marker);

    }
    // print('visibleMarkers length : ' + visibleMarkers.length.toString());
    return visibleMarkers;
  }
}
