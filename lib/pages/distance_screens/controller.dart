import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/pages/distance_screens/state.dart';
import 'package:get/get.dart';

class DistanceScreenController extends GetxController {
  final state = DistanceState();
  final ref = FirebaseFirestore.instance.collection('location').snapshots();
}