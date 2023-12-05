import 'package:f_map/pages/signup_screen/controller.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:get/get.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }

}