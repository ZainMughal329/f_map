import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/reuseable_app_bar.dart';
import 'package:f_map/components/reuseable/snackbar.dart';
import 'package:f_map/components/reuseable/text_widget.dart';
import 'package:f_map/components/session_controller/session_controller.dart';
import 'package:f_map/pages/distance_screens/card_widget.dart';
import 'package:f_map/pages/distance_screens/controller.dart';
import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:get/get.dart';

class DistanceView extends GetView<DistanceScreenController> {
  const DistanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getUpdatedCurrentLocation();
    return Scaffold(
      appBar: reuseAbleAppBar('Distance Screen', AppColors.buttonColor,
          AppColors.buttonTextColor, true),
      backgroundColor: Colors.white,
      body:   SafeArea(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.ref,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.buttonColor,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  Snackbar.showSnackBar('Error', snapshot.error.toString(),
                      Icons.error_outline_outlined);
                  return Container(
                    child: Text("Snapshot error"),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No Items in the Database'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // double vehicleLat = double.parse(snapshot.data!.docs[index]['lat'].toString());
                    // double vehicleLong = double.parse(snapshot.data!.docs[index]['lang'].toString());
                    // double dis =  controller.calculateDistance(vehicleLat, vehicleLong);
                    // print("disIs"+dis.toString());
                    // String uId = controller.auth.currentUser!.uid.toString();
                    controller.state.diss.value = 0.0;
                    controller.state.est.value = 0.0;
                    controller.calculateDistanceAndTime(
                        double.parse(
                          snapshot.data!.docs[index]['lat'].toString(),
                        ),
                        double.parse(
                            snapshot.data!.docs[index]['lang'].toString()),
                        double.parse((double.parse(snapshot
                            .data!.docs[index]['speed']
                            .toString()))
                            .toStringAsFixed(3)));
                    controller.calculateTime(
                        controller.state.diss.value,
                        double.parse((double.parse(snapshot
                            .data!.docs[index]['speed']
                            .toString()))
                            .toStringAsFixed(3)));
                    return snapshot.data!.docs[index]['id'].toString() ==
                        SessionController().userId.toString() ||
                        controller.state.diss.value > 1500
                        ? Container()
                        : cardWidget(
                      snapshot.data!.docs[index]['userName'].toString(),
                      snapshot.data!.docs[index]['vehicleType']
                          .toString(),
                      snapshot.data!.docs[index]['vehicleNum']
                          .toString(),
                      (double.parse(snapshot.data!.docs[index]['speed']
                          .toString()))
                          .toStringAsFixed(3),
                      controller.state.diss.value,
                      controller.state.est.value,
                      // controller.calculateTime(controller.state.diss.value, double.parse((double.parse(snapshot.data!.docs[index]['speed'].toString())).toStringAsFixed(3))),
                    );
                  },
                );
              },
            ),
          )

    );
  }
}
