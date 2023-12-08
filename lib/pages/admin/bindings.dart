import 'package:f_map/pages/admin/index.dart';
import 'package:f_map/pages/map_screen/index.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:get/get.dart';

class AdminBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(() => AdminController());
  }

}