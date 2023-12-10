import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/models/location_model.dart';
import 'package:f_map/pages/drawer/index.dart';
import 'package:f_map/pages/home_screen/index.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class DrawerSideMenuController extends GetxController {
  final state = DrawerState();

  @override
  void onInit() {
    // TODO: implement onInit

    fetchUserName();
    super.onInit();
  }


  fetchUserName() async {
    final snap = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    if(snap.exists){
      final data = snap.data() as Map<String,dynamic>;
      final name = data['userName'];
      final phone = data['email'];
      state.userName.value = name.toString();
      state.email.value = phone.toString();

    }
  }
}
