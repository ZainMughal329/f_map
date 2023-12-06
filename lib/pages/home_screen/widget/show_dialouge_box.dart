import 'package:f_map/components/reuseable/snackbar.dart';
import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, TextEditingController feedBackCon ,{required ValueChanged onValue}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return AlertDialog(
        title: Text('Enter Model Number : '),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(
                  context); // Close the dialog
              // con
                  showFeedbackDialog(context,feedBackCon);
            },
            child: Text(
              'Yes',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              // Action when "No" is clicked
              Navigator.pop(
                  context); // Close the dialog
              // TODO: Perform some other action
            },
            child: Text(
              'No',
              style:
              TextStyle(color: Colors.black),
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
  ).then(onValue);
}

void showFeedbackDialog(BuildContext context,TextEditingController feedbackCon) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    context: context,
    pageBuilder: (_,__,___) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Model Number'),
        content: TextFormField(
          controller: feedbackCon,
          decoration: InputDecoration(
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
                // modelNum = feedbackController.text.toString();
                // Get.to( () => GMapScreen());

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


      tween = Tween(begin: const Offset(-1, -1), end: Offset.zero);

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
