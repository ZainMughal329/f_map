
import 'dart:math';
import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final double latitude1 = 32.0738098;
  final double longitude1 = 72.5905149;
  final double latitude2 = 32.069;
  final double longitude2 = 72.6605149;
  final double knownDistanceMeters = 100.0;

  @override
  Widget build(BuildContext context) {
    // Calculate screen coordinates based on geographical coordinates
    double x1 = calculateXCoordinate(longitude1, context);
    double y1 = calculateYCoordinate(latitude1, context);
    double x2 = calculateXCoordinate(longitude2, context);
    double y2 = calculateYCoordinate(latitude2, context);

    // Calculate the distance between the two points on the screen
    double screenDistance = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));

    // Calculate the scaling factor to achieve the known distance on the screen
    double scaleFactor = knownDistanceMeters / screenDistance;

    // Adjust the position of the second image based on the scaling factor
    double adjustedX2 = x1 + (x2 - x1) * scaleFactor;
    double adjustedY2 = y1 + (y2 - y1) * scaleFactor;

    print('x1: $x1, y1: $y1');
    print('adjustedX2: $adjustedX2, adjustedY2: $adjustedY2');

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: x1,
            top: y1,
            child: Image.asset(
              'assets/images/car.png', // Replace with your image asset path
              width: 20.0, // Set your desired width
              height: 20.0, // Set your desired height
            ),
          ),
          Positioned(
            left: adjustedX2,
            top: adjustedY2,
            child: Image.asset(
              'assets/images/car.png', // Replace with your image asset path
              width: 20.0, // Set your desired width
              height: 20.0, // Set your desired height
            ),
          ),
        ],
      ),
    );
  }

  double calculateXCoordinate(double longitude, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double x = (screenWidth / 360.0) * (longitude + 180.0);
    return x/2;
  }

  double calculateYCoordinate(double latitude, BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double y = (screenHeight / 180.0) * (90.0 - latitude);
    return y/2;
  }
}
