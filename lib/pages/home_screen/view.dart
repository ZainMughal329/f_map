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

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});


  // Widget _buildSelectVehicle(
  //     String vehicleType, String vehicleLogo, BuildContext context) {
  //   return  GestureDetector(
  //     onTap: () {
  //       if (vehicleType == 'Car') {
  //         controller.state.vehicleType = 'Car';
  //
  //         showFeedbackDialog(context,controller.state.feddBackCon);
  //       } else if (vehicleType == 'Bus') {
  //         controller.state.vehicleType = 'Bus';
  //         showFeedbackDialog(context,controller.state.feddBackCon);
  //       } else if (vehicleType == 'Bike') {
  //         controller.state.vehicleType = 'Bike';
  //         showFeedbackDialog(context,controller.state.feddBackCon);
  //       } else {
  //         controller.state.vehicleType = 'none';
  //         // Get.to(() => GMapScreen());
  //       }
  //     },
  //     child: Container(
  //       height: 54,
  //       width: 280,
  //       padding: EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         color: AppColors.buttonColor,
  //         borderRadius: const BorderRadius.only(
  //           topLeft:Radius.circular(30),
  //
  //           bottomRight: Radius.circular(30),
  //         ),
  //         boxShadow: [
  //         ],
  //       ),
  //       child: Row(
  //         mainAxisAlignment: vehicleLogo == ''
  //             ? MainAxisAlignment.center
  //             : MainAxisAlignment.start,
  //         children: [
  //           vehicleLogo == ''
  //               ? Container()
  //               : Container(
  //             padding: EdgeInsets.only(left: 30, right: 25),
  //             child: Image.asset('$vehicleLogo.png'),
  //           ),
  //           TextWidget(title:
  //             'Your vehicle type $vehicleType',
  //               textColor: AppColors.buttonTextColor,
  //               fontSize: 15,
  //               fontWeight: FontWeight.normal,
  //
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSelectVehicle(String vehicleType, String vehicleLogo, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (vehicleType == 'Car' || vehicleType == 'Bus' || vehicleType == 'Bike') {
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
                    color: AppColors.buttonTextColor, // Set your desired text color
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
    return Scaffold(
      appBar: reuseAbleAppBar('Vehicle Selection', AppColors.buttonColor, AppColors.buttonTextColor, false
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSelectVehicle('Car', 'assets/images/car', context),
                SizedBox(height: 30,),
                _buildSelectVehicle('Bus', 'assets/images/bus', context),
                SizedBox(height: 30,),
                _buildSelectVehicle('Bike', 'assets/images/bycicle', context),
                SizedBox(height: 30,),
                _buildSelectVehicle('Nothing', 'assets/images/walk', context),
                // _buildSelectVehicle('Car', 'assets/images/car'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
