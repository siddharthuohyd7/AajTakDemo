import 'package:aajtak/common_ui/button_bar.dart';
import 'package:aajtak/common_ui/drop_down.dart';
import 'package:aajtak/common_ui/rounded_button.dart';
import 'package:aajtak/common_ui/text_input_field.dart';
import 'package:aajtak/utils/styles.dart';
import 'package:flutter/material.dart';

class AddNewProfile extends StatefulWidget {
  static const route = '/AddNewProfile';

  const AddNewProfile({Key? key}) : super(key: key);

  @override
  _AddNewProfileState createState() => _AddNewProfileState();
}

class _AddNewProfileState extends State<AddNewProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Add New Profile',
          style: Styles.appBarRow,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const TextInputField(
                keyboardType: TextInputType.name,
                errorText: 'Enter name',
                title: 'Name',
                rightPadding: 15,
                leftPadding: 15,
              ),
              Row(
                children: const [
                  Flexible(
                      child: TextInputField(
                    keyboardType: TextInputType.number,
                    errorText: 'Enter date',
                    title: 'Date of Birth',
                    fieldType: 'date',
                    hintText: 'DD',
                    rightPadding: 5,
                    leftPadding: 15,
                    maxLength: 2,
                  )),
                  Flexible(
                      child: TextInputField(
                    keyboardType: TextInputType.number,
                    errorText: 'Enter Month',
                    title: '',
                    fieldType: 'month',
                    hintText: 'MM',
                    rightPadding: 5,
                    leftPadding: 5,
                    maxLength: 2,
                  )),
                  Flexible(
                      child: TextInputField(
                    keyboardType: TextInputType.number,
                    errorText: 'Enter year',
                    fieldType: 'year',
                    title: '',
                    hintText: 'YYYY',
                    rightPadding: 15,
                    leftPadding: 5,
                    maxLength: 4,
                  )),
                ],
              ),
              Row(
                children: const [
                  Flexible(
                      child: TextInputField(
                    keyboardType: TextInputType.number,
                    errorText: 'Enter hour',
                    fieldType: 'hour',
                    title: 'Time of Birth',
                    hintText: 'HH',
                    rightPadding: 5,
                    leftPadding: 15,
                    maxLength: 2,
                  )),
                  Flexible(
                      child: TextInputField(
                    keyboardType: TextInputType.number,
                    title: '',
                    errorText: 'Enter Month',
                    fieldType: 'minute',
                    hintText: 'MM',
                    rightPadding: 5,
                    leftPadding: 5,
                    maxLength: 2,
                  )),
                  Flexible(
                      child: Padding(
                          padding: EdgeInsets.only(top: 20, left: 5, right: 15),
                          child: DefaultTabController(
                            child: ButtonTabBar(tabTitles: ['AM', 'PM']),
                            length: 2,
                          ))),
                ],
              ),
              Stack(
                children: [
                  const TextInputField(
                    readOnly: true,
                    hintText: 'Tap to Enter',
                    errorText: 'Enter place',
                    title: 'Place of Birth',
                    rightPadding: 15,
                    leftPadding: 15,
                  ),
                  Positioned(
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.navigate_next,
                        size: 40,
                        color: Colors.indigo,
                      ),
                    ),
                    right: 20,
                    top: 40,
                    bottom: 0,
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                      child: DropDown(
                          errorText: 'Enter gender',
                          title: 'Gender',
                          dropDownMenuItemList: const ['MALE', "FEMALE"],
                          onChanged: (value) {})),
                  const Flexible(
                      child: DropDown(
                          errorText: 'Enter relation', title: 'Relation')),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: size.height * .10),
                  child: RoundedButton(
                    buttonWidth: size.width * 0.3,
                    buttonText: 'Save Changes',
                    backgroundColor: Colors.orangeAccent,
                    onPressed: () {
                      final bool isValid =
                          _formKey.currentState?.validate() ?? false;
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
