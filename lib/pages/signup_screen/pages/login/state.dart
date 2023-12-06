import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class LoginState{
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;
  RxBool loading = false.obs;
  TextEditingController emailCon = TextEditingController();

  TextEditingController passCon = TextEditingController();

}