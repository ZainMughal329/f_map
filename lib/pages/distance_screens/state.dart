import 'package:get/get.dart';

class DistanceState {

  double currentLat = 0.0;
  double currentLang = 0.0;
  double speed = 0.0;
  Rx<double> diss = 0.0.obs;
  Rx<double> est = 0.0.obs;
}