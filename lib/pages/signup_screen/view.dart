import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/custom_text_field.dart';
import 'package:f_map/components/reuseable/reuseable_app_bar.dart';
import 'package:f_map/components/reuseable/round_button.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/signup_screen/index.dart';
import 'package:f_map/pages/splash_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../components/reuseable/text_widget.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reuseAbleAppBar(
          'SignUp', AppColors.buttonColor, AppColors.buttonTextColor, false),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                    contr: controller.state.userNameCon,
                    descrip: 'UserName',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    obsecure: false,
                    icon: Icons.person_2_outlined),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    contr: controller.state.emailCon,
                    descrip: 'Email',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    obsecure: false,
                    icon: Icons.email_outlined),
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
                RoundButton(
                  title: 'SignUp',
                  onPress: () {
                    controller.setLoading(true);
                    Future.delayed(
                      Duration(seconds: 2),
                      () {
                        if (controller.state.emailCon.text.isEmpty ||
                            controller.state.userNameCon.text.isEmpty ||
                            controller.state.passCon.text.isEmpty) {
                          controller.state.error.fire();
                          Future.delayed(
                            Duration(seconds: 3),
                            () {
                              controller.setLoading(false);
                            },
                          );
                        } else if (controller.state.emailCon.text ==
                                'admin@admin.com' &&
                            controller.state.passCon.text == 'admin@123') {
                          controller.state.check.fire();
                          Future.delayed(
                            Duration(seconds: 3),
                            () {
                              // Get.toNamed(RoutesName.homeScreen);
                              controller.setLoading(false);
                            },
                          );
                          // controller.state.confetti.fire();
                        }
                      },
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      title: 'Already have an account??',
                      fontSize: 13,
                    ),
                    InkWell(
                        onTap: () {
                          Get.toNamed(RoutesName.loginScreen);
                        },
                        child: TextWidget(
                          title: 'Login',
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
    );
  }
}
