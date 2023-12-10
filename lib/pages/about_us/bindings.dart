
import 'package:f_map/pages/about_us/index.dart';
import 'package:get/get.dart';

class ABoutUsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutUsController>(() => AboutUsController());
  }

}