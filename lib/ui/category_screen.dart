import 'package:aajtak/common_ui/drop_down.dart';
import 'package:aajtak/common_ui/rounded_button.dart';
import 'package:aajtak/common_ui/text_input_field.dart';
import 'package:aajtak/models/category_model.dart';
import 'package:aajtak/respository/category_repository.dart';
import 'package:aajtak/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static const route = '/Category';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _categoryRepository = CategoryRepository();
  List<String> suggestions = [];
  final ValueNotifier<List<String>> _notifier = ValueNotifier<List<String>>([]);
  List<Category>? _categoryList = [];

  List<String> categoryHeaders = [];
  String dropDownValue = '';

  @override
  void initState() {
    super.initState();
    _categoryRepository.getCategories().then((value) {
      _categoryList = value;
      if (_categoryList != null && _categoryList!.isNotEmpty) {
        categoryHeaders = _categoryList!.map((e) => e.name ?? '').toList();
      }
      dropDownValue = categoryHeaders[0];
      suggestions = _categoryList![0].suggestions ?? [];
      _notifier.value = suggestions;
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'Category',
            style: Styles.appBarRow,
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        color: Colors.indigo,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Wallet Balance: 0',
                              style: Styles.tabText,
                            ),
                            RoundedButton(
                              buttonText: 'Add Money',
                              fontSize: 12,
                              buttonHeight: 25,
                              buttonWidth: 100,
                              backgroundColor: Colors.white,
                              onPressed: () {},
                              textColor: Colors.indigo,
                              borderWidth: 2,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Ask a Question',
                              style: Styles.categoryHeaderStyle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Seek accurate answers to your life problems and get guidance towards the right path.'
                              ' Whether the problem is related to love,self,life,business,money,education or work,our '
                              'astrologers will do an in depth study of your birth chart to provide personalized responses along with remedies.',
                              style: Styles.categoryTextStyle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Choose Category',
                              style: Styles.categoryHeaderStyle,
                            ),
                            DropDown(
                                leftPadding: 0,
                                rightPadding: 0,
                                topPadding: 0,
                                dropdownValue: dropDownValue,
                                errorText: 'Enter gender',
                                title: '',
                                dropDownMenuItemList: categoryHeaders,
                                onChanged: (value) {
                                  suggestions = _categoryList?.firstWhere(
                                          (element) => element.name == value,
                                          orElse: () {
                                        return Category();
                                      }).suggestions ??
                                      [];
                                  _notifier.value = suggestions;
                                }),
                            TextInputField(
                              maxLines: 5,
                              hintText: 'Type a question here',
                              title: '',
                              rightPadding: 0,
                              leftPadding: 0,
                              maxLength: 150,
                              onSaved: (value) {},
                            ),
                            const Text(
                              'Ideas What to Ask (Select Any)',
                              style: Styles.categoryHeaderStyle,
                            ),
                            ValueListenableBuilder<List<String>>(
                              valueListenable: _notifier,
                              builder: (BuildContext context, List<String> list,
                                  Widget? child) {
                                return list.isNotEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ...list.map((value) {
                                            return ListTile(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              dense: true,
                                              title: Text(
                                                value,
                                                style:
                                                    Styles.categoryListTextStyle,
                                              ),
                                            );
                                          })
                                        ],
                                      )
                                    : Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                      );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.indigo,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '\$150(1 Question on Love)',
                        style: Styles.tabText,
                      ),
                      RoundedButton(
                        buttonText: 'Ask now',
                        fontSize: 12,
                        buttonHeight: 30,
                        buttonWidth: 75,
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        textColor: Colors.indigo,
                        borderWidth: 1,
                      )
                    ],
                  ),
                ),
                bottom: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
