import 'package:f_map/pages/home_screen/index.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HomeController extends GetxController {
  final state = HomeState();

  @override
  void onInit() {
    // TODO: implement onInit
    state.btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.onInit();
  }
}