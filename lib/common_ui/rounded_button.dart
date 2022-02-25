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
  final double fontSize;
  final bool enable;
  final Color borderColor;
  final double  ? borderWidth;
   const RoundedButton(
      {required this.buttonText,
        this.borderRadius = 5.0,
        this.onPressed,
        this.buttonWidth=double.maxFinite,
        this.buttonHeight = 50,
        this.fontSize =15,
        this.backgroundColor = Colors.orangeAccent,
        this.textColor = Colors.white,
        this.borderColor =Colors.black87,
        this.borderWidth,
        this.enable = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      child: FittedBox(child: Text(buttonText)),
      style: ElevatedButton.styleFrom(
        textStyle: Styles.buttonStyle.copyWith(fontSize: fontSize),
        onPrimary: textColor,
        primary: backgroundColor,
        minimumSize: Size(buttonWidth, buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape:  RoundedRectangleBorder(
          side: borderWidth!=null ? BorderSide(width: borderWidth!,color: borderColor):BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
      onPressed: enable ? onPressed : null,
    );
  }

}
