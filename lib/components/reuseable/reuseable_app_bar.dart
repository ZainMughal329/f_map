import 'package:f_map/components/reuseable/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget reuseAbleAppBar(String title , Color color,Color textColor , bool moveBack) {
  return AppBar(

    title: TextWidget(
      title: title,
      textColor: textColor,
    ),
    backgroundColor: color,
    automaticallyImplyLeading: moveBack,
  );
}