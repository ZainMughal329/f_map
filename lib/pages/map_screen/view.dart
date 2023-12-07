import 'dart:async';

import 'package:f_map/pages/map_screen/index.dart';
import 'package:f_map/pages/splash_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends GetView<MapController> {
  MapScreen({super.key});
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition myPos = CameraPosition(
    target: LatLng(32.070638, 72.654050),
    zoom: 14,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: myPos,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          // markers: Set<Marker>.of(marker),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_city_rounded),
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(32.070638, 72.654050), zoom: 14),
              ),
            );
            // setState(() {});
          }),
    );
  }
}
