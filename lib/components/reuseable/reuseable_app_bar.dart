import 'package:f_map/components/reuseable/text_widget.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/components/session_controller/session_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget reuseAbleAppBar(String title , Color color,Color textColor , bool moveBack) {
  return AppBar(

    title: TextWidget(
      title: title,
      textColor: textColor,
    ),
    backgroundColor: color,
    automaticallyImplyLeading: moveBack,
    actions: [
      IconButton(
        onPressed: () async{
          await FirebaseAuth.instance.signOut().then((value){
            SessionController().userId = null;
            Get.offAllNamed(RoutesName.loginScreen);
          }).onError((error, stackTrace){

          });
        },
        icon: Icon(Icons.logout),
      ),
    ],
  );
}