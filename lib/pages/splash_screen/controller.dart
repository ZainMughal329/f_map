import 'package:f_map/components/routes/routes.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final state = SplashState();


  @override
  void onInit() {
    // TODO: implement onInit
    checkAuthentication();
    super.onInit();
  }

  checkAuthentication() {
    Future.delayed(Duration(seconds: 3) , () {
      Get.offAllNamed(RoutesName.signUpScreen);
    });
  }
}