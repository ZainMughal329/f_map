import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart' as adp;
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

  adp.AudioPlayer audioPlayer = adp.AudioPlayer();


   playAlertSound() async {

AssetsAudioPlayer.playAndForget(Audio("assets/sound/alert.mp3"),);
// AssetsAudioPlayer.newPlayer().open(playable);
//      AssetsAudioPlayer.newPlayer().open(
//        Audio("assets/sound/alert.mp3"),
//        autoStart: true,
//        showNotification: true,
//      );
    print('Alert');
    //  await audioPlayer.play(soundPath as adp.AssetSource).then((value){
    //    print("sound played");
    //  });
    // // int result = await audioPlayer.play('assets/alert_sound.mp3'); // Replace 'assets/alert_sound.mp3' with the path to your sound file
    //  await audioPlayer.play();

    // if (result == 1) {
    //   // success
    //   print('Alert sound played successfully');
    // } else {
    //   print('Error playing alert sound');
    // }
  }



  getUpdatedCurrentLocation() async {

    _location.onLocationChanged.listen((LocationData locationData) async {
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


  double radians(double degrees) {
    return degrees * (pi / 180.0);
  }

  double calculateDistanceAndTime(double lat1, double lon1, double speed) {
    // state.diss.value= 0.0;
    // Radius of the Earth in meters
    const double R = 6371000.0;

    // Convert latitude and longitude from degrees to radians
    lat1 = radians(lat1);
    lon1 = radians(lon1);
    double lat2 = radians(state.currentLat);
    double lon2 = radians(state.currentLang);

    // Differences in coordinates
    double dlat = lat2 - lat1;
    double dlon = lon2 - lon1;

    // Haversine formula
    double a = pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    double distance = R * c;

    double FixedDiss = double.parse(distance.toStringAsFixed(2));
    state.diss.value = FixedDiss;
    // calculateTime(speed, FixedDiss);
    print(FixedDiss);

    return FixedDiss;
  }


//   double calculateDistanceAndTime(double lat1, double lon1, double speed) {
// print("current Lat" + state.currentLat.toString());
// print("current Long" + state.currentLang.toString());
//     // fetchUserDetails();
//     const double earthRadius = 6371; // in meters
//
//     double dLat = _toRadians( state.currentLat - lat1);
//     // double dLat = _toRadians(lat1 - state.currentLat );
//     double dLon = _toRadians(state.currentLang - lon1);
//     // double dLon = _toRadians(lon1 - state.currentLang );
//
//     double a = pow(sin(dLat / 2), 2) +
//         cos(_toRadians(lat1)) * cos(_toRadians(state.currentLat)) * pow(sin(dLon / 2), 2);
//     double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//
//     // distance in kms
//     double distance = (earthRadius * c);
//
//
//     state.diss.value = double.parse(distance.toStringAsFixed(2));
//     double FixedDiss = double.parse(distance.toStringAsFixed(2));
//     state.est.value = calculateTime(speed, FixedDiss);
//     return state.diss.value;
//   }
//
//   double _toRadians(double degree) {
//     return degree * pi / 180;
//   }


  double calculateTime(double distance, double speed) {
    // Convert speed from Km/h to meters per second
    double speedInMetersPerSecond = speed * (1000.0 / 3600.0);

    // Calculate time in seconds
    double timeInSeconds = distance / speedInMetersPerSecond;
    state.est.value = double.parse(timeInSeconds.toStringAsFixed(1))  ;
    print(state.est.value);
    return state.est.value ;
  }

  // double calculateTime(double speedKmPerHour, double distanceMeters) {
  //   // Convert speed from km/h to m/s
  //   double speedMetersPerSecond = speedKmPerHour * 1000 / 3600;
  //
  //   // Calculate time in seconds
  //   double timeSeconds = distanceMeters / speedMetersPerSecond;
  //
  //   // Convert time from seconds to hours
  //   double timeMin = timeSeconds / 60;
  //
  //
  //   return timeMin;
  // }
  
  // fetchUserDetails()async{
  //   DocumentSnapshot user = await locRef.doc(SessionController().userId.toString()).get();
  //   state.currentLat = double.parse(user['lat'].toString());
  //   state.currentLang = double.parse(user['lang'].toString());
  // }

}