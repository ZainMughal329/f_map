import 'package:f_map/pages/map_screen/index.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  final state = MapState();

  @override
  void onInit() {
    // TODO: implement onInit
    _initMap();
    super.onInit();
  }

  Future<void> _initMap() async {
    await goToCurrentLocation();
  }

  GoogleMapController? mapController;
  Location _location = Location();

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

}
