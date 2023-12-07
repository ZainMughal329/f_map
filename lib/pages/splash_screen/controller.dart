import 'package:f_map/components/routes/routes.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/components/session_controller/session_controller.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final state = SplashState();
  final auth = FirebaseAuth.instance;




  checkAuthentication() {
    Future.delayed(Duration(seconds: 6) , () async{
      if(await isAlreadyLogin()){
        Get.offAllNamed(RoutesName.homeScreen);
      }else{
        Get.offAllNamed(RoutesName.loginScreen);
      }



    });
  }
  Future<bool> isAlreadyLogin() async{
    if(auth.currentUser != null){
      SessionController().userId = auth.currentUser!.uid.toString();
      return true;
    }else
      return false;
  }
}