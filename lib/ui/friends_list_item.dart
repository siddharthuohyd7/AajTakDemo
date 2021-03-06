import 'package:aajtak/models/relatives_model.dart';
import 'package:aajtak/utils/helper.dart';
import 'package:aajtak/utils/styles.dart';
import 'package:flutter/material.dart';

import 'add_new_profile.dart';

class FriendsListItem extends StatelessWidget {
  final Relative relative;
  final void Function(Relative relative) ? deleteCallback;

  const FriendsListItem({Key? key, required this  .relative,this.deleteCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(

              child: Text(
                relative.fullName ?? '',
                style: Styles.itemText,
              ),
            ),
            Flexible(
              child: FittedBox(
                child: Text(
                  getDate(getNetworkDateTime(relative.dateAndTimeOfBirth ?? '') ??
                          DateTime.now()) ??
                      '',
                  style: Styles.itemText,
                ),
              ),
            ),
            Flexible(
              child: FittedBox(
                child: Text(
                  getTime(
                          relative.birthDetails?.tobHour,
                          relative.birthDetails?.tobMin,
                          relative.birthDetails?.meridiem) ??
                      '',
                  style: Styles.itemText,
                ),
              ),
            ),

            Flexible(
              child: Text(
                relative.relation ?? '',
                style: Styles.itemText,
              ),
            ),
            Flexible(
              child: IconButton(
                onPressed: (){
                  Navigator.of(context)
                      .pushNamed(AddNewProfile.route,arguments: relative);
                },
               icon: Icon(
                  Icons.edit,
                  color: Colors.orange[700],
                ),
              ),
            ),
            Flexible(
              child: IconButton(
                onPressed: (){
                  deleteCallback!(relative);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )
              ),
            ),

          ],
        ),
      ),
    );
  }
}
