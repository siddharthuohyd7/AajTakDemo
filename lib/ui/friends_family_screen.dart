import 'package:aajtak/common_ui/rounded_button.dart';
import 'package:aajtak/ui/add_new_profile.dart';
import 'package:aajtak/ui/friends_list_item.dart';
import 'package:aajtak/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendsFamilyScreen extends StatefulWidget {
  const FriendsFamilyScreen({Key? key}) : super(key: key);

  @override
  _FriendsFamilyScreenState createState() => _FriendsFamilyScreenState();
}

class _FriendsFamilyScreenState extends State<FriendsFamilyScreen> {
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
        child: Column(
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
                    itemCount: 5,
                    itemBuilder: (_, index) {
                      return const FriendsListItem();
                    })),
            Padding(
              padding: const EdgeInsets.all(20),
                child: RoundedButton(
                  buttonWidth: MediaQuery.of(context).size.width * 0.3 ,
              buttonText: 'Add New Profile',
              backgroundColor: Colors.orangeAccent,
              onPressed: () {
                    Navigator.of(context).pushNamed(AddNewProfile.route);
              },
            ))
          ],
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
