import 'package:f_map/components/reuseable/snackbar.dart';
import 'package:f_map/components/reuseable/text_widget.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/home_screen/controller.dart';
import 'package:f_map/pages/map_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


void showFeedbackDialog(BuildContext context,TextEditingController feedbackCon) {
  final con = Get.put(HomeController());
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    context: context,
    pageBuilder: (_,__,___) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: TextWidget(title:'Model Number'),
        content: TextFormField(
          controller: feedbackCon,
          decoration: InputDecoration(
            helperStyle: GoogleFonts.poppins(
              fontSize: 14,

            ),
            hintText: 'Enter Model Number :',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              if (feedbackCon.text.isEmpty) {
                Snackbar.showSnackBar('Error',
                  'Feedback Required \nPlease provide feedback before deleting.',Icons.error_outline,
                  // snackPosition: SnackPosition.BOTTOM,
                );
              } else {
                // deleteItem();
                con.state.modelNum = feedbackCon.text.trim().toString();
                con.storeDataInFirebase();
                Get.toNamed(RoutesName.mapScreen);

              }
              feedbackCon.clear(); // Clear the text field
            },
            child: Text('Ok'),
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
        // child: FadeTransition(
        //   opacity: anim,
        //   child: child,
        // ),
        child: child,
      );
    },

  );
}
