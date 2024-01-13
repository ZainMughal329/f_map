import 'package:f_map/components/colors/app_colors.dart';
import 'package:f_map/components/reuseable/snackbar.dart';
import 'package:f_map/components/reuseable/text_widget.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/home_screen/controller.dart';
import 'package:f_map/pages/map_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void showFeedbackDialog(
    BuildContext context, TextEditingController feedbackCon) {
  final con = Get.put(HomeController());
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    context: context,
    pageBuilder: (_, __, ___) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: TextWidget(title: 'Model Number'),
        content: TextFormField(
          controller: feedbackCon,
          cursorColor: AppColors.buttonColor,
          keyboardType: TextInputType.text,
          style: GoogleFonts.poppins(
            fontSize: 14,
          ),
          decoration: InputDecoration(



            border:UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.buttonColor,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.buttonColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.buttonColor,
              ),
            ),
            helperStyle: GoogleFonts.poppins(
              fontSize: 14,
            ),
            hintText: 'Enter Model Number :',
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              if (feedbackCon.text.isEmpty) {
                Snackbar.showSnackBar(
                  'Error',
                  'Feedback Required \nPlease provide feedback before deleting.',
                  Icons.error_outline,
                  // snackPosition: SnackPosition.BOTTOM,
                );
              } else {
                print("vehicelType"+con.state.vehicleType.toString());
                con.state.modelNum = feedbackCon.text.trim().toString();
                con.storeDataInFirebase();

              }
              feedbackCon.clear(); // Clear the text field
            },
            child: TextWidget(
              title: 'Ok',
              textColor: AppColors.buttonColor,
            ),
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
