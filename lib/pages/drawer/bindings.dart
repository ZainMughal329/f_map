import 'package:f_map/pages/drawer/controller.dart';
import 'package:f_map/pages/home_screen/index.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:get/get.dart';

class DrawerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrawerSideMenuController>(() => DrawerSideMenuController());
  }

}