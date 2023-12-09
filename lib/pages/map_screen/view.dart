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
import 'dart:math';

import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/reuseable_app_bar.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/map_screen/controller.dart';
import 'package:f_map/pages/map_screen/widget/speedometer_widget.dart';
import 'package:f_map/pages/map_screen/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rive/rive.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../utils/rive_utils.dart';
import '../drawer/view.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

final controller = Get.put(MapController());
late SMIBool isSideBarClosed;
bool isSideMenuClosed = true;
late AnimationController _animationController;
late Animation<double> animation;
late Animation<double> sclAnimation;

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    sclAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

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

                  SystemNavigator.pop().then((value) async {
                    // await _controller.locRef.child(SessionController().userId.toString()).remove();

                    controller.deleteCurrentNode();
                  }).onError((error, stackTrace) {
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
        // appBar: reuseAbleAppBar('Google Map', AppColors.buttonColor,
        //     AppColors.buttonTextColor, false),
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
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                    height: MediaQuery.of(context).size.height,
                    width: 288,
                    left: isSideMenuClosed ? -288 : 0,
                    top: 0,
                    child: SideMenu(),
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(
                          animation.value - 30 * animation.value * pi / 180),
                    child: Transform.translate(
                      offset: Offset(animation.value * 265, 0),
                      child: Transform.scale(
                        scale: sclAnimation.value,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(isSideMenuClosed ? 0 : 12),
                          child: Stack(
                            children: [
                              Obx(
                                () => GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target:
                                        controller.state.currentLocation.value,
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
                                  myLocationButtonEnabled: true,
                                  // Hide my location button
                                  mapToolbarEnabled: true,
                                  // Disable map toolbar
                                  buildingsEnabled:
                                      true, // Show 3D buildings if available
                                  // indoorViewEnabled: true, // Disable indoor view
                                  // minMaxZoomPreference: MinMaxZoomPreference(10.0, 20.0),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: GetBuilder<MapController>(
                                  builder: (con) => SpeedoMeterWidget(
                                    speed: con.state.speed,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                    left: isSideMenuClosed ? 0 : 220,
                    top: -5,
                    child: MenuBtn(
                      onPress: () {
                        isSideBarClosed.value = !isSideBarClosed.value;
                        if (_animationController.value == 0) {
                          _animationController.forward();
                        } else {
                          _animationController.reverse();
                        }
                        setState(() {
                          isSideMenuClosed = !isSideMenuClosed;
                        });
                      },
                      riveOnInit: (artboard) {
                        final con = StateMachineController.fromArtboard(
                            artboard, "State Machine");

                        artboard.addController(con!);

                        isSideBarClosed =
                            con.findInput<bool>("isOpen") as SMIBool;
                        isSideBarClosed.value = true;
                      },
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
