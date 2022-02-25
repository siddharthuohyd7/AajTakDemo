import 'package:aajtak/utils/styles.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final title;
  final fieldRequired;
  final String hintText;
  final Function(String?)? onChanged;
  final String? errorText;
  final String dropdownValue;
  final List<String>? dropDownMenuItemList;
  final Function(String?)? onValidate;
  final double rightPadding;
  final double leftPadding;
  final double topPadding;
  const DropDown({
    Key? key,
    required this.title,
    this.leftPadding=16,
    this.topPadding=16,
    this.fieldRequired = false,
    this.hintText = "",
    this.onChanged,
    this.errorText,
    this.dropdownValue = "",
    this.dropDownMenuItemList,
    this.onValidate,
    this.rightPadding = 10,
  }) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? selectedValue;
  List<DropdownMenuItem<String>>? list = [];

  @override
  void initState() {
    super.initState();
    if(widget.dropdownValue.isNotEmpty&&  !widget.dropDownMenuItemList!.contains(widget.dropdownValue)){
      widget.dropDownMenuItemList!.add(widget.dropdownValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    list = widget.dropDownMenuItemList
        ?.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: Styles.textHintStyle,
        ),
      );
    }).toList();
    selectedValue = widget.dropdownValue.isEmpty ? null : widget.dropdownValue;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(widget.leftPadding, widget.topPadding, widget.rightPadding, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                text: widget.title,
                style: Styles.textInputStyle,
                children: [
                  TextSpan(
                    text: widget.fieldRequired ? ' *' : '',
                    style: Styles.textInputStyle.copyWith(color: Colors.red),
                  )
                ]),
          ),
          widget.title.toString().isEmpty ?const SizedBox.shrink() :
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
            decoration: InputDecoration(
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
            items: list,
            onChanged: (String? newValue) {
              setState(() {
                if( widget.onChanged!=null){
                  widget.onChanged!(newValue);
                }

                selectedValue = newValue;
              });
            },
            hint: Text(
              widget.hintText,
              style: Styles.textHintStyle,
            ),
            isExpanded: true,
            value: selectedValue,
            icon: const Icon(Icons.arrow_drop_down,color: Colors.black87,),
            iconSize: 24,
            elevation: 16,
            validator: (value) {
              if (value == null) return widget.errorText;
              return null;
            },
          ),
        ],
      ),
    );
  }
}
