import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/routes/routes.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/components/session_controller/session_controller.dart';
import 'package:f_map/pages/profile/index.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/reuseable/snackbar.dart';

class ProfileController extends GetxController {
  final state = ProfileState();
  FirebaseAuth auth = FirebaseAuth.instance;

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

  void setLogoutLoading(bool val){
    state.logoutLoading.value = val;
  }

  Future<void> handleLogout() async{
    setLogoutLoading(true);
    try{
      await auth.signOut().then((value){
        // SessionController().userId = null;
        setLogoutLoading(false);
        Get.offAllNamed(RoutesName.loginScreen);
        Snackbar.showSnackBar('Logout', 'Successfully', Icons.done_outline_rounded);
      }).onError((error, stackTrace){
        setLogoutLoading(false);
        Snackbar.showSnackBar('Error', error.toString(), Icons.error_outline);
      });
    }catch(e){
      setLogoutLoading(false);
      Snackbar.showSnackBar('Error', e.toString(), Icons.error_outline);
    }
  }
}