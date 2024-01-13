import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/pages/distance_screens/controller.dart';
import 'package:f_map/pages/distance_screens/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

final state = DistanceState();
final cont = DistanceScreenController();

Widget cardWidget(String name, String type, String number, String speed,
    double distance, double est) {
  if (distance < 400) {
    cont.playAlertSound();
  }
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
    child: Container(
      child: Stack(
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Name: $name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Vehicle Type: $type',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Vehicle Number: $number',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Vehicle Speed: $speed km/h',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Remanining Distance: $distance meters',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'EST arrival time(sec): $est s',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 15),
                  LinearGauge(
                    gaugeOrientation: GaugeOrientation.horizontal,
                    linearGaugeBoxDecoration: LinearGaugeBoxDecoration(
                      thickness: 8,
                      borderRadius: 10,
                      linearGradient: LinearGradient(
                        colors: [
                          AppColors.warningColor,
                          AppColors.yellowColor,
                          AppColors.buttonColor,
                        ],
                      ),
                    ),
                    end: 1500.0,
                    steps: 300.0,
                    enableGaugeAnimation: true,
                    rulers: RulerStyle(
                      rulerPosition: RulerPosition.bottom,
                      showLabel: true,
                    ),
                    pointers: [
                      Pointer(
                        value: 0,
                        labelStyle: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: PointerShape.triangle,
                        // showLabel: true,
                        color: AppColors.buttonColor,
                        height: 30,
                        width: 20,
                      ),
                      Pointer(
                        value: distance,
                        labelStyle: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: PointerShape.triangle,
                        showLabel: true,
                        // color: distance >400 && distance <500 ? AppColors.buttonColor : AppColors.warningColor,
                        // color: AppColors.warningColor,
                        color: distance > 0 && distance <= 400
                            ? AppColors.warningColor
                            : distance > 400 && distance <= 1000
                                ? AppColors.yellowColor
                                : AppColors.buttonColor,
                        height: 30,
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 15,
              right: 30,
              child: type == "Car"
                  ? Column(
                      children: [
                        Container(
                          // height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Lottie.asset("assets/animations/car2.json"),
                        ),
                        Container(
                          height: 5,
                          width: 70,
                          decoration: BoxDecoration(
                            // border: Border.a,
                            color: distance > 0 && distance <= 300
                                ? AppColors.warningColor
                                : distance > 300 && distance <= 700
                                    ? AppColors.yellowColor
                                    : AppColors.buttonColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    )
                  // ? Icon(
                  //     Icons.car_crash,
                  //     size: 100,
                  //     color: distance > 0 && distance <= 300
                  //         ? AppColors.warningColor
                  //         : distance > 300 && distance <= 700
                  //             ? AppColors.yellowColor
                  //             : AppColors.buttonColor,
                  //   )
                  : type == "Bike"
                      ? Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                // border: Border.a,

                                borderRadius: BorderRadius.circular(20),
                              ),
                              child:
                                  Lottie.asset("assets/animations/bike2.json"),
                            ),
                            Container(
                              height: 5,
                              width: 70,
                              decoration: BoxDecoration(
                                // border: Border.a,
                                color: distance > 0 && distance <= 300
                                    ? AppColors.warningColor
                                    : distance > 300 && distance <= 700
                                        ? AppColors.yellowColor
                                        : AppColors.buttonColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        )
                      : type == "Bus"
                          ? Column(
                              children: [
                                Container(
                                  // height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    // border: Border.a,

                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Lottie.asset(
                                      "assets/animations/truck2.json"),
                                ),
                                Container(
                                  height: 5,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    // border: Border.a,
                                    color: distance > 0 && distance <= 300
                                        ? AppColors.warningColor
                                        : distance > 300 && distance <= 700
                                            ? AppColors.yellowColor
                                            : AppColors.buttonColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              // height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                // border: Border.a,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child:
                                  Lottie.asset("assets/animations/walk1.json"),
                            )),
        ],
      ),
    ),
  );
}
