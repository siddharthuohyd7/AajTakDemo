import 'package:aajtak/models/relatives_model.dart';
import 'package:aajtak/utils/helper.dart';
import 'package:aajtak/utils/styles.dart';
import 'package:flutter/material.dart';

class FriendsListItem extends StatelessWidget {
  final Relative relative;

  const FriendsListItem({Key? key, required this.relative}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              relative.fullName ?? '',
              style: Styles.itemText,
            ),
            Text(
              getDate(getNetworkDateTime(relative.dateAndTimeOfBirth ?? '') ??
                      DateTime.now()) ??
                  '',
              style: Styles.itemText,
            ),
            Text(
              getTime(
                      relative.birthDetails?.tobHour,
                      relative.birthDetails?.tobMin,
                      relative.birthDetails?.meridiem) ??
                  '',
              style: Styles.itemText,
            ),
            Text(
              relative.relation ?? '',
              style: Styles.itemText,
            ),
            Icon(
              Icons.edit,
              color: Colors.orange[700],
            ),
            const Icon(
              Icons.delete,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
