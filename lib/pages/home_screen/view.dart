import 'dart:math';

import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/reuseable_app_bar.dart';
import 'package:f_map/components/reuseable/round_button.dart';
import 'package:f_map/components/reuseable/text_widget.dart';
import 'package:f_map/components/routes/routes.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/home_screen/index.dart';
import 'package:f_map/pages/home_screen/widget/show_dialouge_box.dart';
import 'package:f_map/pages/splash_screen/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../utils/rive_utils.dart';
import '../drawer/view.dart';
import '../map_screen/widget/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final controller = Get.put(HomeController());
late SMIBool isSideBarClosed;
bool isSideMenuClosed = true;
late AnimationController _animationController;
late Animation<double> animation;
late Animation<double> sclAnimation;

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.ease),
    );
    sclAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _animationController.dispose();
  //   super.dispose();
  // }

  // Widget _buildSelectVehicle(
  Widget _buildSelectVehicle(
      String vehicleType, String vehicleLogo, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (vehicleType == 'Car' ||
            vehicleType == 'Bus' ||
            vehicleType == 'Bike') {
          controller.state.vehicleType = vehicleType;
          showFeedbackDialog(context, controller.state.feddBackCon);
        } else {
          controller.state.vehicleType = 'none';
          // Get.to(() => GMapScreen());
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.buttonColor, // Set your desired background color
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (vehicleLogo.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.buttonColor,
                    backgroundImage: AssetImage('$vehicleLogo.png'),
                  ),
                ),
              Flexible(
                child: Text(
                  'Your vehicle type is $vehicleType',
                  style: TextStyle(
                    color: AppColors.buttonTextColor,
                    // Set your desired text color
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchUserName();
    return Scaffold(
      // appBar: reuseAbleAppBar(
      //   'Vehicle Selection',
      //   AppColors.buttonColor,
      //   AppColors.buttonTextColor,
      //   false,
      // ),
      body: Obx(() => controller.state.userName.value == '' ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              color: AppColors.buttonColor,
            ),
          ),
        ],
      ) : SingleChildScrollView(
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 10),
              curve: Curves.ease,
              height: MediaQuery.of(context).size.height,
              width: 288,
              left: isSideMenuClosed ? -288 : 0,
              top: 0,
              child: SideMenu(),
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(1 * animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                  scale: sclAnimation.value,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(isSideMenuClosed ? 0 : 12),
                    child: Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 15,),


                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  TextWidget(title: 'Hi , ' , fontSize: 25,fontWeight: FontWeight.bold,),
                                  TextWidget(title: controller.state.userName.value.capitalizeFirst.toString(), fontSize: 25,fontWeight: FontWeight.bold,),

                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: TextWidget(title: 'Select your vehicle type from here.',fontSize: 19,fontWeight: FontWeight.w500,),
                            ),
                            SizedBox(height: 10,),

                            _buildSelectVehicle(
                                'Car', 'assets/images/car', context),
                            SizedBox(
                              height: 30,
                            ),
                            _buildSelectVehicle(
                                'Bus', 'assets/images/bus', context),
                            SizedBox(
                              height: 30,
                            ),
                            _buildSelectVehicle(
                                'Bike', 'assets/images/bycicle', context),
                            SizedBox(
                              height: 30,
                            ),
                            _buildSelectVehicle(
                                'Nothing', 'assets/images/walk', context),
                            SizedBox(
                              height: 30,
                            ),
                            RoundButton(
                                title: 'To Distance Screen',
                                onPress: () {
                                  Get.toNamed(RoutesName.distanceScreen);
                                }),
                            // _buildSelectVehicle('Car', 'assets/images/car'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isSideMenuClosed ? 0 : 220,
              top: 0,
              child: MenuBtn(
                onPress: () {
                  isSideBarClosed.value = !isSideBarClosed.value;
                  if (_animationController.value == 0) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                  setState(() {
                    isSideMenuClosed = isSideBarClosed.value;
                  });
                },
                riveOnInit: (artboard) {
                  StateMachineController con = RiveUtls.getRiveController(
                      artboard,
                      stateMachineName: "State Machine");
                  isSideBarClosed = con.findInput<bool>("isOpen") as SMIBool;
                  isSideBarClosed.value = true;
                },
              ),
            ),
          ],
        ),
      ),),
    );
  }
}
