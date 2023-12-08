
import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/reuseable_app_bar.dart';
import 'package:f_map/pages/admin/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AdminScreen extends GetView<AdminController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reuseAbleAppBar('Google Map', AppColors.buttonColor,
          AppColors.buttonTextColor, false),
      body: FutureBuilder(
        future: controller.checkLocationPermission(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            controller.showMarkersList();
            // controller.getVisibleMarkers();
            return Stack(
              children: [
                Obx(
                  () => GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: controller.state.currentLocation.value,
                      zoom: 15.0,
                      bearing: 0, // Set the initial bearing
                      tilt: 45.0,
                    ),
                    onMapCreated: (GoogleMapController con) {
                      controller.mapController = con;
                      controller.goToCurrentLocation();
                    },
                    markers: Set<Marker>.from(
                      controller.getVisibleMarkers(),
                    ),
                    mapType: MapType.normal,
                  ),
                ),

              ],
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // controller.goToCurrentLocation();
      //     // print(controller.visibleMarkers);
      //     controller.getVisibleMarkers();
      //   },
      //   child: Icon(Icons.location_searching),
      // ),
    );
  }
}
