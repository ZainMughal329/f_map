import 'dart:ffi';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState{
  GoogleMapController? mapController;
  var currentLocation = LatLng(0.0, 0.0).obs;
  final markerList = <Marker>[].obs;


}