import 'package:aajtak/utils/styles.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  final String buttonText;
  final double borderRadius;
  final Function()? onPressed;
  final double buttonWidth;
  final double buttonHeight;
  final Color backgroundColor;
  final Color textColor;
  final bool enable;

   const RoundedButton(
      {required this.buttonText,
        this.borderRadius = 5.0,
        this.onPressed,
        this.buttonWidth=double.maxFinite,
        this.buttonHeight = 50,
        this.backgroundColor = Colors.orangeAccent,
        this.textColor = Colors.white,
        this.enable = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      child: Text(buttonText),
      style: ElevatedButton.styleFrom(
        textStyle: Styles.buttonStyle,
        onPrimary: textColor,
        primary: backgroundColor,
        minimumSize: Size(buttonWidth, buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
      onPressed: enable ? onPressed : null,
    );
  }

}
