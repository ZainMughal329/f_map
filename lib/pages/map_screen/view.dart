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
import 'package:f_map/pages/map_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: FutureBuilder(
        future: controller.checkLocationPermission(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                Obx(() => GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(0, 0),
                        zoom: 15.0,
                      ),
                      onMapCreated: (GoogleMapController con) {
                        controller.mapController = con;
                        controller.goToCurrentLocation();
                      },
                    )),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToCurrentLocation();
        },
        child: Icon(Icons.location_searching),
      ),
    );
  }
}
