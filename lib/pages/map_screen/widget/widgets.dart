import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({super.key, required this.onPress, required this.riveOnInit});

  final VoidCallback onPress;
  final ValueChanged<Artboard> riveOnInit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: 16,
          ),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(
                  0,
                  3,
                ),
                blurRadius: 9,
              ),
            ],
          ),
          child: RiveAnimation.asset(
            'assets/riveAssets/menu_button.riv',
            onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
}
