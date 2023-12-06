import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/custom_text_field.dart';
import 'package:f_map/components/reuseable/reuseable_app_bar.dart';
import 'package:f_map/components/reuseable/round_button.dart';
import 'package:f_map/components/reuseable/text_widget.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/signup_screen/index.dart';
import 'package:f_map/pages/signup_screen/pages/login/index.dart';
import 'package:f_map/pages/splash_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../../components/reuseable/snackbar.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reuseAbleAppBar(
          'Login', AppColors.buttonColor, AppColors.buttonTextColor, false),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                  ),
                  CustomTextField(
                      contr: controller.state.emailCon,
                      descrip: 'Email',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      obsecure: false,
                      icon: Icons.person),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      contr: controller.state.passCon,
                      descrip: 'Password',
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obsecure: true,
                      icon: Icons.lock_open_outlined),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => controller.state.loading.value
                      ? RoundButton(title: 'Login', onPress: () {
                        print('object');
                  })
                      : RoundButton(
                          title: 'Login',
                          onPress: () {
                            print('121');
                            Future.delayed(
                              Duration(seconds: 0),
                              () {
                                if (controller.state.emailCon.text.isEmpty ||
                                    controller.state.passCon.text.isEmpty) {
                                  Snackbar.showSnackBar(
                                      "Error",
                                      'All fields must be filled.',
                                      Icons.error_outline);
                                } else {
                                  controller.loginUserWithEmailAndPassword(
                                    controller.state.emailCon.text.trim(),
                                    controller.state.passCon.text.trim(),
                                  );
                                  // controller.state.confetti.fire();
                                }
                              },
                            );
                          },
                        )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        title: 'Not have an account??',
                        fontSize: 13,
                      ),
                      InkWell(
                          onTap: () {
                            Get.toNamed(RoutesName.signUpScreen);
                          },
                          child: TextWidget(
                            title: 'SignUp',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.buttonColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.buttonColor,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.state.loading.value
                  ? Positioned.fill(
                      child: Column(
                        children: [
                          Spacer(
                            flex: 2,
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            child: RiveAnimation.asset(
                              'assets/riveAssets/check.riv',
                              onInit: (artboard) {
                                StateMachineController con =
                                    controller.getRiveControllers(artboard);

                                controller.state.error =
                                    con.findInput<bool>('Error') as SMITrigger;
                                controller.state.check =
                                    con.findInput<bool>('Check') as SMITrigger;
                                controller.state.reset =
                                    con.findInput<bool>('Reset') as SMITrigger;
                              },
                            ),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
