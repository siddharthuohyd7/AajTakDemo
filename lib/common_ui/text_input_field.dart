import 'package:aajtak/utils/helper.dart';
import 'package:aajtak/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TextInputField extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final String title;
  final readOnly;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final String fieldType;
  final Function(String?)? onValidate;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final String? errorText;
  final double? rightPadding;
  final double? leftPadding;
  final double? topPadding;
  final double? bottomPadding;
  final TextEditingController? textController;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final String description;
  final List<String>? autoFillHints;

  const TextInputField(
      {Key? key,
      required this.title,
      this.initialValue,
      this.hintText,
      this.readOnly = false,
      this.keyboardType,
      this.maxLines,
      this.maxLength,
      this.fieldType = '',
      this.onValidate,
      this.errorText,
      this.textController,
      this.onSaved,
      this.inputFormatters,
      this.rightPadding,
      this.leftPadding,
      this.topPadding,
      this.bottomPadding,
      this.onChanged,
      this.textInputAction,
      this.autoFillHints,
      this.description = ''})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        leftPadding != null ? leftPadding! : 15,
        topPadding != null ? topPadding! : 16,
        rightPadding != null ? rightPadding! : 0,
        bottomPadding != null ? bottomPadding! : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.textInputStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            style: Styles.textInputStyle,
            autofillHints: autoFillHints,
            keyboardType: keyboardType,
            readOnly: readOnly,
            initialValue: initialValue,
            maxLength: maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLines: maxLines,
            onSaved: onSaved,
            textInputAction: TextInputAction.next,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              isDense: false,
              focusColor: Colors.black54,
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.blue, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
            validator: (value) {
              if (onValidate != null) onValidate!(value?.trim());
              if (value == null || value.isEmpty) {
                return errorText;
              }
              switch (fieldType) {
                case '':
                  if (value.isEmpty) {
                    return errorText;
                  }
                  return null;
                case 'email':
                  if ((value.isNotEmpty) &&
                      (!emailValidator(value))) {
                    return 'Please enter valid email.';
                  }
                  return null;
                case 'hour':
                  if ((value.isNotEmpty) &&
                      !(int.parse(value) > 0 && int.parse(value) < 12)) {
                    return 'Not Valid.';
                  }
                  return null;

                case 'minute':
                  if ((value.isNotEmpty) &&
                      !(int.parse(value) > 0 && int.parse(value) < 60)) {
                    return 'Not Valid.';
                  }
                  return null;
                case 'date':
                  if ((value.isNotEmpty) &&
                      !(int.parse(value) > 0 && int.parse(value) < 31)) {
                    return 'Not Valid.';
                  }
                  return null;
                case 'month':
                  if ((value.isNotEmpty) &&
                      !(int.parse(value) > 0 && int.parse(value) < 12)) {
                    return 'Not Valid.';
                  }
                  return null;
                case 'year':
                  int? year =
                      int.tryParse(DateFormat('yyyy').format(DateTime.now()));
                  if (year != null) {
                    if ((value.isNotEmpty) &&
                        !(int.parse(value) > 0 && int.parse(value) < year)) {
                      return 'Not Valid.';
                    }
                  }
                  return null;
                case 'phone':
                  return null;
              }
            },
          ),
        ],
      ),
    );
  }
}
