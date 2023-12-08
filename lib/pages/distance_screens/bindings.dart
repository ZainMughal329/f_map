import 'package:f_map/pages/distance_screens/controller.dart';
import 'package:get/get.dart';

class DistanceScreenBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DistanceScreenController>(() => DistanceScreenController());
  }

}