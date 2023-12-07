// import 'dart:async';
//
// import 'package:f_map/pages/map_screen/index.dart';
// import 'package:f_map/pages/splash_screen/controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapScreen extends GetView<MapController> {
//   MapScreen({super.key});
//   Completer<GoogleMapController> _controller = Completer();
//   static final CameraPosition myPos = CameraPosition(
//     target: LatLng(32.070638, 72.654050),
//     zoom: 14,
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: GoogleMap(
//           // mapType: MapType.hybrid,
//           initialCameraPosition: CameraPosition(
//             target: LatLng(32.070638, 72.654050),
//             zoom: 14,
//           ),
//           onMapCreated: (con) {
//             print('inside');
//             controller.state.mapController = con;
//             print('executed');
//           },
//           // markers: Set<Marker>.of(marker),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.location_city_rounded),
//           onPressed: () async {
//             // GoogleMapController controller = await _controller.future;
//             // controller.animateCamera(
//             //   CameraUpdate.newCameraPosition(
//             //     CameraPosition(target: LatLng(32.070638, 72.654050), zoom: 14),
//             //   ),
//             // );
//             // setState(() {});
//           }),
//     );
//   }
// }
import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/reuseable_app_bar.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/map_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends GetView<MapController> {
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
                    trafficEnabled: true,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    // zoomControlsEnabled: false, // Hide zoom controls
                    // compassEnabled: false, // Hide compass
                    // rotateGesturesEnabled: true, // Disable rotation gestures
                    // scrollGesturesEnabled: true, // Enable scroll gestures
                    // tiltGesturesEnabled: true, // Enable tilt gestures
                    myLocationButtonEnabled: true, // Hide my location button
                    mapToolbarEnabled: true, // Disable map toolbar
                    buildingsEnabled: true, // Show 3D buildings if available
                    // indoorViewEnabled: true, // Disable indoor view
                    // minMaxZoomPreference: MinMaxZoomPreference(10.0, 20.0),
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // controller.goToCurrentLocation();
          // print(controller.visibleMarkers);
          controller.getVisibleMarkers();
        },
        child: Icon(Icons.location_searching),
      ),
    );
  }
}
