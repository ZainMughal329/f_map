
import 'package:f_map/pages/faq_view/index.dart';
import 'package:get/get.dart';

class FAQBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FAQController>(() => FAQController());
  }

}