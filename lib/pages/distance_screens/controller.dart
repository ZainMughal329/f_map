import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/session_controller/session_controller.dart';
import 'package:f_map/pages/distance_screens/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

import 'package:location/location.dart';

class DistanceScreenController extends GetxController {
  final state = DistanceState();
  final auth = FirebaseAuth.instance;
  final ref = FirebaseFirestore.instance.collection('location').snapshots();
  final locRef = FirebaseFirestore.instance.collection("location");
  Location _location = Location();


  getUpdatedCurrentLocation() async {

    _location.onLocationChanged.listen((LocationData locationData) async {
      print('called');
      state.currentLat = locationData.latitude!.toDouble();
      state.currentLang = locationData.longitude!.toDouble();
      state.speed = locationData.speed! * 3.6;
      // update();
      await FirebaseFirestore.instance
          .collection('location')
          .doc(auth.currentUser!.uid.toString())
          .update({
        'lat': locationData.latitude!.toDouble(),
        'lang': locationData.longitude!.toDouble(),
        'speed': state.speed,
      }).then((value) {
        // goToCurrentLocation();
        // print('before');
        // print('speed val : ' + state.speed.toString());

        // showMarkersList();
        // getVisibleMarkers();

        // print('new location fetched');
      }).onError((error, stackTrace) {
        // print('failed');
      });
    });
  }


  double calculateDistance(double lat1, double lon1) {

    // fetchUserDetails();
    const double earthRadius = 6371; // in meters

    // double dLat = _toRadians( state.currentLat - lat1);
    double dLat = _toRadians(lat1 - state.currentLat );
    // double dLon = _toRadians(state.currentLang - lon1);
    double dLon = _toRadians(lon1 - state.currentLang );

    double a = pow(sin(dLat / 2), 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(state.currentLat)) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = (earthRadius * c)+100;
    state.diss.value = double.parse(distance.toStringAsFixed(2));
    return state.diss.value;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }
  
  // fetchUserDetails()async{
  //   DocumentSnapshot user = await locRef.doc(SessionController().userId.toString()).get();
  //   state.currentLat = double.parse(user['lat'].toString());
  //   state.currentLang = double.parse(user['lang'].toString());
  // }

}