 import 'package:f_map/components/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';

Widget cardWidget (String name, String type ,String number, String speed , String arrivalTime , String distance){
  return Padding(
    padding: const EdgeInsets.only(top:10,left: 5,right: 5),
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
                    'EST arrival time: 10sec',
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
                    end: 200.0,
                    steps: 20.0,
                    enableGaugeAnimation: true,
                    rulers: RulerStyle(
                      rulerPosition: RulerPosition.bottom,
                      showLabel: true,
                    ),
                    pointers: const [
                      Pointer(
                        value: 0,
                        labelStyle: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: PointerShape.triangle,
                        showLabel: true,
                        color: AppColors.buttonColor,
                        height: 30,
                        width: 20,
                      ),
                      Pointer(
                        value: 80,
                        labelStyle: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: PointerShape.triangle,
                        showLabel: true,
                        color: AppColors.warningColor,
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
              child: Icon(Icons.car_crash,size: 100,color: AppColors.buttonColor,)),
        ],
      ),
    ),
  );
}