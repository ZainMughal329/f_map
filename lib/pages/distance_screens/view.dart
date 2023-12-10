import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/snackbar.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
        stream: controller.ref,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.buttonColor,
                ),
              );
            }
            if (snapshot.hasError) {
              Snackbar.showSnackBar('Error', snapshot.error.toString(),Icons.error_outline_outlined);
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
                controller.state.diss.value=0.0;
                controller.state.est.value=0.0;
                controller.calculateDistanceAndTime(double.parse(snapshot.data!.docs[index]['lat'].toString(),), double.parse(snapshot.data!.docs[index]['lang'].toString()),double.parse((double.parse(snapshot.data!.docs[index]['speed'].toString())).toStringAsFixed(3)));
                controller.calculateTime(controller.state.diss.value, double.parse((double.parse(snapshot.data!.docs[index]['speed'].toString())).toStringAsFixed(3)));
                print( "value"+ controller.state.diss.value.toString());
                print( controller.state.est.value);

                return snapshot.data!.docs[index]['id'].toString() == SessionController().userId.toString() ?
                Container() : cardWidget(
                  snapshot.data!.docs[index]['userName'].toString(),
                  snapshot.data!.docs[index]['vehicleType'].toString(),
                  snapshot.data!.docs[index]['vehicleNum'].toString(),
                  (double.parse(snapshot.data!.docs[index]['speed'].toString())).toStringAsFixed(3),
                  // controller.calculateDistanceAndTime(double.parse(snapshot.data!.docs[index]['lat'].toString(),), double.parse(snapshot.data!.docs[index]['lang'].toString()),double.parse((double.parse(snapshot.data!.docs[index]['speed'].toString())).toStringAsFixed(3))),
                    // controller.state.est.value,
                  controller.state.diss.value,
                  controller.state.est.value,
                  // controller.calculateTime(controller.state.diss.value, double.parse((double.parse(snapshot.data!.docs[index]['speed'].toString())).toStringAsFixed(3))),
                );

                // return Padding(
                //   padding: const EdgeInsets.only(top:10,left: 5,right: 5),
                //   child: Container(
                //     child: Stack(
                //       children: [
                //         Card(
                //           elevation: 5,
                //           child: Padding(
                //             padding: EdgeInsets.all(16),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.stretch,
                //               children: [
                //                 Text(
                //                   'Name: John Doe',
                //                   style: TextStyle(
                //                     fontSize: 18,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //                 SizedBox(height: 5),
                //                 Text(
                //                   'Vehicle Type: Car',
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     color: Colors.grey,
                //                   ),
                //                 ),
                //                 SizedBox(height: 5),
                //                 Text(
                //                   'Vehicle Number: ABC 123',
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     color: Colors.grey,
                //                   ),
                //                 ),
                //                 SizedBox(height: 5),
                //                 Text(
                //                   'Vehicle Speed: 40KM/h',
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     color: Colors.grey,
                //                   ),
                //                 ),
                //                 SizedBox(height: 5),
                //                 Text(
                //                   'EST arrival time: 10sec',
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     color: Colors.grey,
                //                   ),
                //                 ),
                //                 SizedBox(height: 15),
                //                 LinearGauge(
                //                   gaugeOrientation: GaugeOrientation.horizontal,
                //                   linearGaugeBoxDecoration: LinearGaugeBoxDecoration(
                //                     thickness: 8,
                //                     borderRadius: 10,
                //                     linearGradient: LinearGradient(
                //                       colors: [
                //                         AppColors.warningColor,
                //                         AppColors.yellowColor,
                //                         AppColors.buttonColor,
                //                       ],
                //                     ),
                //                   ),
                //                   end: 200.0,
                //                   steps: 20.0,
                //                   enableGaugeAnimation: true,
                //                   rulers: RulerStyle(
                //                     rulerPosition: RulerPosition.bottom,
                //                     showLabel: true,
                //                   ),
                //                   pointers: const [
                //                     Pointer(
                //                       value: 0,
                //                       labelStyle: TextStyle(
                //                         color: AppColors.textColor,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                       shape: PointerShape.triangle,
                //                       showLabel: true,
                //                       color: AppColors.buttonColor,
                //                       height: 30,
                //                       width: 20,
                //                     ),
                //                     Pointer(
                //                       value: 80,
                //                       labelStyle: TextStyle(
                //                         color: AppColors.textColor,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                       shape: PointerShape.triangle,
                //                       showLabel: true,
                //                       color: AppColors.warningColor,
                //                       height: 30,
                //                       width: 20,
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         Positioned(
                //             top: 15,
                //             right: 30,
                //             child: Icon(Icons.car_crash,size: 100,color: AppColors.buttonColor,)),
                //       ],
                //     ),
                //   ),
                // );
              },
            );
          },
        ),
      ),
    );
  }
}
