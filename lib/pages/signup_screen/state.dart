import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class SignUpState{
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  RxBool loading = false.obs;
  TextEditingController emailCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();

  TextEditingController userNameCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

}