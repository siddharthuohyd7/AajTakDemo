import 'package:aajtak/common_ui/button_bar.dart';
import 'package:aajtak/common_ui/drop_down.dart';
import 'package:aajtak/common_ui/loading_indicator_dialog.dart';
import 'package:aajtak/common_ui/rounded_button.dart';
import 'package:aajtak/common_ui/text_input_field.dart';
import 'package:aajtak/models/places_model.dart';
import 'package:aajtak/models/relatives_model.dart';
import 'package:aajtak/providers/refresh_event_provider.dart';
import 'package:aajtak/respository/friends_repository.dart';
import 'package:aajtak/ui/places_search.dart';
import 'package:aajtak/utils/helper.dart';
import 'package:aajtak/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewProfile extends StatefulWidget {
  static const route = '/AddNewProfile';
  final Relative? relative;


   const AddNewProfile({Key? key, this.relative}) : super(key: key);

  @override
  _AddNewProfileState createState() => _AddNewProfileState();
}

class _AddNewProfileState extends State<AddNewProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isNew = true;
  Relative? relative;
  final FriendsRepository _friendsRepository = FriendsRepository();
  @override
  void initState() {
    super.initState();
    isNew = (widget.relative == null);
    relative = (isNew ? Relative() : widget.relative)!;
    if (isNew) {
      relative?.birthPlace = BirthPlace();
      relative?.birthDetails = BirthDetails();
      relative?.birthDetails?.meridiem ='AM';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            isNew ? 'Add New Profile' : 'Edit New profile',
            style: Styles.appBarRow,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextInputField(
                    keyboardType: TextInputType.name,
                    initialValue: relative?.fullName ?? '',
                    errorText: 'Enter name',
                    title: 'Name',
                    rightPadding: 15,
                    onSaved: (value) {
                      saveNames(value);
                    },
                    leftPadding: 15,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: TextInputField(
                        initialValue:
                            relative?.birthDetails?.dobDay?.toString() ?? '',
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          relative?.birthDetails?.dobDay =
                              int.tryParse(value ?? '0');
                        },
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
                        initialValue:
                            relative?.birthDetails?.dobMonth?.toString() ?? '',
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          relative?.birthDetails?.dobMonth =
                              int.tryParse(value ?? '0');
                        },
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
                        initialValue:
                            relative?.birthDetails?.dobYear?.toString() ?? '',
                        keyboardType: TextInputType.number,
                        errorText: 'Enter year',
                        onSaved: (value) {
                          relative?.birthDetails?.dobYear =
                              int.tryParse(value ?? '0');
                        },
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
                    children: [
                      Flexible(
                          child: TextInputField(
                        initialValue:
                            relative?.birthDetails?.tobHour?.toString() ?? '',
                        keyboardType: TextInputType.number,
                        errorText: 'Enter hour',
                        onSaved: (value) {
                          relative?.birthDetails?.tobHour =
                              int.tryParse(value ?? '0');
                        },
                        fieldType: 'hour',
                        title: 'Time of Birth',
                        hintText: 'HH',
                        rightPadding: 5,
                        leftPadding: 15,
                        maxLength: 2,
                      )),
                      Flexible(
                          child: TextInputField(
                        initialValue:
                            relative?.birthDetails?.tobMin?.toString() ?? '',
                        keyboardType: TextInputType.number,
                        title: '',
                        onSaved: (value) {
                          relative?.birthDetails?.tobMin =
                              int.tryParse(value ?? '0');
                        },
                        errorText: 'Enter Month',
                        fieldType: 'minute',
                        hintText: 'MM',
                        rightPadding: 5,
                        leftPadding: 5,
                        maxLength: 2,
                      )),
                      Flexible(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 5, right: 15),
                              child: DefaultTabController(
                                initialIndex: [
                                  'AM',
                                  'PM'
                                ].indexOf(relative?.birthDetails?.meridiem ?? 'AM'),
                                child: ButtonTabBar(
                                  tabTitles: const ['AM', 'PM'],
                                  callback: (value) {
                                    relative?.birthDetails?.meridiem = value;
                                  },
                                ),
                                length: 2,
                              ))),
                    ],
                  ),
                  Stack(
                    children: [
                      TextInputField(
                        initialValue: relative?.birthPlace?.placeName,
                        key: UniqueKey(),
                        hintText: 'Tap to Enter',
                        errorText: 'Enter place',
                        title: 'Place of Birth',
                        rightPadding: 15,
                        leftPadding: 15,
                        onSaved: (value) {
                          relative?.birthPlace?.placeName = value ?? '';
                        },
                      ),
                      Positioned(
                        child: InkWell(
                          onTap: () async {
                            Place place = await Navigator.of(context)
                                .pushNamed(PlacesSearchScreen.route) as Place;
                            relative?.birthPlace?.placeName = place.placeName;
                            relative?.birthPlace?.placeId = place.placeId;
                            setState(() {});
                          },
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
                              dropdownValue: relative?.gender ?? '',
                              errorText: 'Enter gender',
                              title: 'Gender',
                              dropDownMenuItemList: const ['MALE', "FEMALE"],
                              onChanged: (value) {
                                relative?.gender = value ?? '';
                              })),
                      Flexible(
                        child: DropDown(
                          dropdownValue: relative?.relation ?? '',
                          errorText: 'Enter relation',
                          title: 'Relation',
                          dropDownMenuItemList: getAllPossibleRelatives(),
                          onChanged: (value) {
                            relative?.relation = value ?? '';
                            relative?.relationId =
                                (getAllPossibleRelatives().indexOf(value ?? '') ) +
                                    1;
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: size.height * .10),
                      child: RoundedButton(
                        buttonWidth: size.width * 0.3,
                        buttonText: 'Save Changes',
                        backgroundColor: Colors.orangeAccent,
                        onPressed: () async  {
                          final bool isValid =
                              _formKey.currentState?.validate() ?? false;
                          if (isValid) {
                            _formKey.currentState?.save();
                            debugPrint(
                                '********** RESPONSE *************** ${relative?.toJson().toString()}');
                            try {
                              if (isNew) {
                                showLoadingIndicator(context,message: 'Adding Profile');
                                await _friendsRepository.addRelative(relative);
                                Provider.of<RefreshProviderEvent>(context,listen: false).updateMsg = 'Added Profile';
                              } else {
                                showLoadingIndicator(context,message: 'Updating Profile');
                                await _friendsRepository.updateRelative(relative);
                                Provider.of<RefreshProviderEvent>(context,listen: false).updateMsg = 'Updated Profile';
                              }
                              hideDialog();
                              Navigator.of(context).pop('SUCCESS');
                            }catch(e){
                              hideDialog();
                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Please try again! ${e.toString()}')));
                              debugPrint(e.toString());
                            }

                          }
                        },
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveNames(String? value) {
    value = value?.trim();
    relative?.fullName = value;
    if (value!.contains(" ")) {
      List list = value.split(" ");
      if (list.length == 1) {
        relative?.firstName = list[0];
      } else if (list.length == 2) {
        relative?.firstName = list[0];
        relative?.lastName = list[1];
      } else {
        relative?.firstName = list[0];
        relative?.lastName = list[1];
        relative?.middleName = list[2];
      }
    }else{
      relative?.firstName = value;
    }
  }
}
