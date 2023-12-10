import 'package:f_map/pages/profile/controller.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:get/get.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }

}