
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obsecure;
  IconData icon;
  Widget? label;
  TextEditingController contr;
  FocusNode? focNode;
  String descrip;
  bool readOnly;
  final void Function(String)? onChange;

  CustomTextField({
    super.key,
    required this.contr,
    required this.descrip,
    this.focNode,
    this.label,
    required this.textInputAction,
    required this.keyboardType,
    required this.obsecure,
    required this.icon,
    this.onChange,
    this.readOnly = false,

    //
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 2,
            offset: Offset(0, 3), // changes the position of the shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: TextField(
          controller: contr,

          readOnly: readOnly,
          textInputAction: textInputAction,
          obscureText: obsecure,
          keyboardType: keyboardType,
          onChanged: onChange,
          style: GoogleFonts.poppins(
            fontSize: 17,
          ),

          // focusNode: focNode,
          decoration: InputDecoration(
            label: label,
            prefixIcon: Icon(
              icon,
              color: AppColors.iconsColor,
            ),
            border: InputBorder.none,
            hintText: descrip,
            hintStyle: GoogleFonts.poppins(
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
