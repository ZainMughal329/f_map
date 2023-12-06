import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/reuseable_app_bar.dart';
import 'package:f_map/components/reuseable/round_button.dart';
import 'package:f_map/components/routes/routes.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/home_screen/index.dart';
import 'package:f_map/pages/home_screen/widget/show_dialouge_box.dart';
import 'package:f_map/pages/splash_screen/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reuseAbleAppBar('Home Screen', AppColors.buttonColor,
          AppColors.buttonTextColor, false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              showCustomDialog(context, controller.state.feddBackCon ,onValue: (_){

              });
            },
            child: Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
          ),

          RoundButton(title: 'LogOut', onPress: () async {
            await FirebaseAuth.instance.signOut().then((value) {
              Get.offAllNamed(RoutesName.loginScreen);
            });
           }),
        ],
      ),
    );
  }
}
