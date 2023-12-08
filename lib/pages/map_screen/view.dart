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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MapScreen extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent app from exiting when back button is pressed
        // Show an exit confirmation dialog to the user
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);

                  SystemNavigator.pop().then((value)async{
                    // await _controller.locRef.child(SessionController().userId.toString()).remove();

                    controller.deleteCurrentNode();
                  }).onError((error, stackTrace){
                    // Utils.showToast(error.toString());
                    print('error');

                  });
                },
              ),
            ],
          ),
        );

        // Return false to prevent default system back button behavior
        return false;
      },
      child: Scaffold(
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

                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: GetBuilder<MapController>(
                      builder: (con) => Container(
                        height: 110,
                        width: 110,
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 0,
                              maximum: 200,
                              labelOffset: 10,
                              axisLineStyle: AxisLineStyle(
                                  thicknessUnit: GaugeSizeUnit.factor,
                                  thickness: 0.03),
                              majorTickStyle: MajorTickStyle(
                                  length: 2,
                                  thickness: 0.5,
                                  color: Colors.black),
                              minorTickStyle: MinorTickStyle(
                                  length: 2,
                                  thickness: 0.5,
                                  color: Colors.black),
                              axisLabelStyle: GaugeTextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 10),
                              ranges: <GaugeRange>[
                                GaugeRange(
                                  startValue: 0,
                                  endValue: 200,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  startWidth: 0.03,
                                  endWidth: 0.03,
                                  gradient: SweepGradient(
                                    colors: const <Color>[
                                      Colors.green,
                                      Colors.yellow,
                                      Colors.red
                                    ],
                                    stops: const <double>[0.0, 0.5, 1],
                                  ),
                                ),
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                  value: con.state.speed,
                                  needleLength: 0.95,
                                  enableAnimation: true,
                                  animationType: AnimationType.ease,
                                  needleStartWidth: 0.20,
                                  needleEndWidth: 2,
                                  needleColor: Colors.red,
                                  knobStyle: KnobStyle(knobRadius: 0.05),
                                ),
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            con.state.speed
                                                .toStringAsFixed(2)
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 7,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 05),
                                          Text(
                                            'kmph',
                                            style: TextStyle(
                                                fontSize: 7,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    angle: 90,
                                    positionFactor: 0.75),
                              ],
                            ),
                          ],
                        ),
                      ),
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
      ),
    );
  }
}
