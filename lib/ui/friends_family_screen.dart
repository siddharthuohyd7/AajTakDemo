import 'dart:async';

import 'package:aajtak/common_ui/loading_indicator_dialog.dart';
import 'package:aajtak/common_ui/rounded_button.dart';
import 'package:aajtak/models/relatives_model.dart';
import 'package:aajtak/providers/refresh_event_provider.dart';
import 'package:aajtak/respository/friends_repository.dart';
import 'package:aajtak/ui/add_new_profile.dart';
import 'package:aajtak/ui/category_screen.dart';
import 'package:aajtak/ui/friends_list_item.dart';
import 'package:aajtak/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendsFamilyScreen extends StatefulWidget {
  const FriendsFamilyScreen({Key? key}) : super(key: key);

  @override
  _FriendsFamilyScreenState createState() => _FriendsFamilyScreenState();
}

class _FriendsFamilyScreenState extends State<FriendsFamilyScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<RefreshProviderEvent>(context, listen: true);
  }

  void _deleteCallback(Relative relative) async {
    debugPrint('RELATIVE ${relative.uuid}');
    DeleteTemplateAction deleteTemplateAction = await showCustomDialog(context,
        message: 'Do you really want to Delete?');
    if (deleteTemplateAction == DeleteTemplateAction.YES) {
      showLoadingIndicator(context, message: 'Deleting Profile');
      try{
        await FriendsRepository().deleteRelative(relative);
        hideDialog();
        setState(() {
        });
      }catch(e){
        hideDialog();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Friends and Family Screen',
          style: Styles.appBarRow,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder<List<Relative>>(
          future: FriendsRepository().getRelatives(),
          builder: (buildContext, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeaderText('Name'),
                          _buildHeaderText('DOB'),
                          _buildHeaderText('TOB'),
                          _buildHeaderText('Relation'),
                          const SizedBox(
                            width: 10,
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (_, index) {
                              Relative relative =
                                  snapshot.data?[index] ?? Relative();
                              return FriendsListItem(
                                relative: relative,
                                deleteCallback: _deleteCallback,
                              );
                            })),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [Flexible(
                            child: RoundedButton(

                              buttonText: 'Add New Profile',
                              backgroundColor: Colors.orangeAccent,
                              onPressed: () async {
                                Navigator.of(context)
                                    .pushNamed(AddNewProfile.route);
                              },
                            ),
                          ),
                           const SizedBox(width: 15,),
                            Flexible(
                            child: RoundedButton(
                              buttonText: 'Category',
                              backgroundColor: Colors.orangeAccent,
                              onPressed: () async {
                                Navigator.of(context)
                                    .pushNamed(CategoryScreen.route);
                              },
                            ),
                          ),]
                        ))
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    'No data found',
                    style: Styles.errorText,
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Text _buildHeaderText(String header) {
    return Text(
      header,
      style: Styles.headerText,
    );
  }
}
