import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/reuseable_app_bar.dart';
import 'package:f_map/components/reuseable/round_button.dart';
import 'package:f_map/components/reuseable/text_widget.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/profile/index.dart';
import 'package:f_map/pages/profile/update/update.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: (){
                          Get.to(UpdateView(),);
                        },
                        leading: CircleAvatar(
                          backgroundColor: AppColors.buttonColor,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: controller.image == null
                                ? snapshot.data!['photoUrl'].toString() == ''
                                ? Center(
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: AppColors.iconsColor,
                              ),
                            )
                                : Image(
                              image: NetworkImage(snapshot
                                  .data!['photoUrl']
                                  .toString()),
                              fit: BoxFit.cover,
                            )
                                : Image.file(
                              File(controller.image!.path).absolute,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: TextWidget(
                          title: snapshot.data!['userName'].toString()
                              .toString(),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // textColor: Colors.white,
                        ),
                        subtitle: TextWidget(
                          title: snapshot.data!['email'].toString(),
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
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.iconsColor,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
