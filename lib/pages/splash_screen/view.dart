import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/reuseable_app_bar.dart';
import 'package:f_map/components/reuseable/text_widget.dart';
import 'package:f_map/pages/splash_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.checkAuthentication();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              height: 300,
              child: RiveAnimation.asset('assets/riveAssets/map.riv'),
            ),
            Container(
              child: TextWidget(
                title: 'Splash Screen',
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

  }
}
