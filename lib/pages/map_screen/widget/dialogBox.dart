import 'package:f_map/pages/map_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/colors/app_colors.dart';
import '../../../components/reuseable/snackbar.dart';
import '../../../components/reuseable/text_widget.dart';

void showExitDialogBox(
    BuildContext context) {
  final con = Get.put(MapController());
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    context: context,
    pageBuilder: (_, __, ___) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: TextWidget(title: 'Exit App'),
        content: TextWidget(title: 'Are you sure you want to exit the app?'),
        actions: [
          TextButton(
            child: TextWidget(
              title: 'No',
              textColor: AppColors.buttonColor,
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: TextWidget(
              title: 'Yes',
              textColor: AppColors.buttonColor,
            ),
            onPressed: () {
              Navigator.pop(context);

              SystemNavigator.pop().then((value) async {
                // await _controller.locRef.child(SessionController().userId.toString()).remove();

                con.deleteCurrentNode();
              }).onError((error, stackTrace) {
                // Utils.showToast(error.toString());
                print('error');
              });
            },
          ),
        ],
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;

      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: anim, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
  );
}
