import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/reuseable_app_bar.dart';
import 'package:f_map/components/reuseable/round_button.dart';
import 'package:f_map/components/reuseable/text_widget.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/profile/index.dart';
import 'package:f_map/pages/splash_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  Widget _reuseAbleListTile(
    IconData leadingIcon,
    IconData tralingIcon,
    String title,
      VoidCallback onPress,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          ListTile(
            onTap: onPress,
            leading: Icon(
              leadingIcon,
              color: AppColors.buttonColor,
            ),
            title: TextWidget(
              title: title,
              // textColor: Colors.white,
            ),
            trailing: Icon(
              tralingIcon,
              color: AppColors.buttonColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 24,
            ),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchUserName();
    return Scaffold(
      appBar: reuseAbleAppBar(
          'Profile', AppColors.buttonColor, AppColors.buttonTextColor, true),
      body: Obx(
        () => controller.state.userName.value == ''
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.buttonColor,
                    ),
                  ),
                ],
              )
            : Container(
                // height: double.infinity,
                // color: Color(0xff17203a),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.buttonColor,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: TextWidget(
                        title: controller.state.userName.value.capitalizeFirst
                            .toString(),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        // textColor: Colors.white,
                      ),
                      subtitle: TextWidget(
                        title: controller.state.email.value.toString(),
                        fontSize: 14,
                        textColor: Colors.grey,
                        // textColor: Colors.white,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.buttonColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 24,
                      ),
                      child: Divider(),
                    ),
                    _reuseAbleListTile(Icons.social_distance,
                        Icons.arrow_forward_ios, 'Distance Screen', () {
                      Get.toNamed(RoutesName.distanceScreen);
                        },),
                    _reuseAbleListTile(Icons.question_answer_outlined,
                        Icons.arrow_forward_ios, "FAQ's",() {
                        Get.toNamed(RoutesName.faq);
                      },),
                    _reuseAbleListTile(Icons.details_outlined,
                        Icons.arrow_forward_ios, 'About Us',() {
                        Get.toNamed(RoutesName.aboutUs);
                      },),
                    _reuseAbleListTile(Icons.star_rate_outlined,
                        Icons.arrow_forward_ios, 'Rate Us',() {
                        // Get.toNamed(RoutesName.distanceScreen);
                      },),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      return controller.state.logoutLoading.value
                          ? Container(
                              child: Center(
                                  child: CircularProgressIndicator(
                              color: AppColors.iconsColor,
                            )))
                          : RoundButton(
                              title: 'LogOut',
                              onPress: () {
                                controller.handleLogout();
                              },
                            );
                    }),
                  ],
                ),
              ),
      ),
    );
  }
}
