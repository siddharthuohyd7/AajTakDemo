import 'package:aajtak/common_ui/rounded_button.dart';
import 'package:aajtak/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BuildContext? dialogContext;

void showLoadingIndicator(
  BuildContext context, {
  String message = 'Loading...',
  bool isDismissible = false,
  double opacity = 0.5,
}) {
  dialogContext = context;
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        SizedBox(width: 10,),
        Container(margin: const EdgeInsets.only(left: 7),

            child: Text(message)),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
enum DeleteTemplateAction { YES, NO }
Future showCustomDialog( BuildContext context,{String message=''}){
  dialogContext = context;
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(

          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(15.0)),
          //this right here
          child: SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(child: Text(message,style: Styles.textInputStyle,)),

                  Row(
                    children:  [
                      Flexible(child: RoundedButton(buttonText: 'Yes',buttonHeight: 40,
                        onPressed: (){
                        Navigator.of(dialogContext!).pop(DeleteTemplateAction.YES);
                      },),),
                      const SizedBox(width: 15,),
                      Flexible(child: RoundedButton(buttonText: 'No',buttonHeight: 40,
                        onPressed: (){
                        Navigator.of(dialogContext!).pop(DeleteTemplateAction.NO);
                      },)),
                    ],
                  )

                ],
              ),
            ),
          ),
        );
      });
}

void hideDialog() {
  if (dialogContext != null) Navigator.of(dialogContext!).pop();
}
