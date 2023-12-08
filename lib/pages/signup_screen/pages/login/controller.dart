import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/signup_screen/index.dart';
import 'package:f_map/pages/signup_screen/pages/login/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../../components/reuseable/snackbar.dart';
import '../../../../components/session_controller/session_controller.dart';
import '../../../../components/session_controller/shared_prefs.dart';

class LoginController extends GetxController {
  final state = LoginState();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  StateMachineController getRiveControllers(Artboard artboard) {
    StateMachineController? stateMachineController =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(stateMachineController!);
    return stateMachineController;
  }

  setLoading(val) {
    state.loading.value = val;
  }

  void loginUserWithEmailAndPassword(String email, password) async {
    setLoading(true);
    try {
      if(email == 'admin@admin.com' && password == 'admin@123') {
        Future.delayed(
          Duration(seconds: 3),
              () {
                setLoading(false);
            Get.offAllNamed(RoutesName.adminScreen);
          },
        );
      } else {
        await auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          SessionController().userId = value.user!.uid.toString();

          StorePrefrences sp = StorePrefrences();
          sp.setIsFirstOpen(true);
          state.check.fire();
          Future.delayed(
            Duration(seconds: 3),
                () {
              Get.offAllNamed(RoutesName.homeScreen);
              setLoading(false);
            },
          );


          state.emailCon.clear();
          state.passCon.clear();
        }).onError((error, stackTrace) {
          Snackbar.showSnackBar("Error", error.toString(), Icons.error_outline);
          state.error.fire();
          Future.delayed(
            Duration(seconds: 3),
                () {
              setLoading(false);
            },
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      Snackbar.showSnackBar("Error", e.toString(), Icons.error_outline);
      state.error.fire();
      Future.delayed(
        Duration(seconds: 3),
        () {
          setLoading(false);
        },
      );
    } catch (e) {
      Snackbar.showSnackBar("Error", e.toString(), Icons.error_outline);
      state.error.fire();
      Future.delayed(
        Duration(seconds: 3),
        () {
          setLoading(false);
        },
      );
    }
  }
}
