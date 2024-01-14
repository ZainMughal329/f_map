import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/signup_screen/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../components/models/user_model.dart';
import '../../components/reuseable/snackbar.dart';
import '../../components/session_controller/session_controller.dart';
import '../../components/session_controller/shared_prefs.dart';

class SignUpController extends GetxController {
  final state = SignUpState();

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

  // user signUp Functions {
  void registerUserWithEmailAndPassword(
      UserModel userinfo, String email, password) async {
    setLoading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        userinfo.id = auth.currentUser!.uid.toString();
        SessionController().userId = value.user!.uid.toString();
        StorePrefrences sp = StorePrefrences();
        sp.setIsFirstOpen(true);
        Snackbar.showSnackBar(
            'Success', 'Successfully create an account.', Icons.done_all);
        state.check.fire();
        Future.delayed(
          Duration(seconds: 3),
          () {
            createUser(userinfo);
            setLoading(false);
          },
        );
        clearControllers();
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

  createUser(UserModel user) async {
    setLoading(true);
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toJson())
        .whenComplete(() {
      print('Account created Successfully');

      setLoading(false);
      StorePrefrences sp = StorePrefrences();
      sp.setIsFirstOpen(true);
      Get.offAllNamed(RoutesName.homeScreen);
      print('success');
    }).catchError((error, stackTrace) {
      Snackbar.showSnackBar("Error", error.toString(), Icons.error_outline);
      setLoading(false);
    });
  }

  void storeUser(
      UserModel user, BuildContext context, String email, String pass) async {
    registerUserWithEmailAndPassword(user, email, pass);
  }

  clearControllers() {
    state.emailCon.clear();
    state.passCon.clear();
    state.phoneCon.clear();
    state.userNameCon.clear();
  }
}
