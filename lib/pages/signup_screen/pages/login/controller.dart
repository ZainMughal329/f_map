import 'package:f_map/pages/signup_screen/index.dart';
import 'package:f_map/pages/signup_screen/pages/login/index.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class LoginController extends GetxController {
  final state = LoginState();

  StateMachineController getRiveControllers(Artboard artboard) {
    StateMachineController? stateMachineController =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(stateMachineController!);
    return stateMachineController;
  }
  setLoading(val) {
    state.loading.value = val;
  }
}
