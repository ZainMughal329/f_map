
import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src , routeName;
  late SMIBool? input;

  RiveAsset(this.src, this.routeName,
      {required this.artboard,
        required this.stateMachineName,
        required this.title,
        this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}