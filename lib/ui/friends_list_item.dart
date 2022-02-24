
import 'package:aajtak/utils/styles.dart';
import 'package:flutter/material.dart';

class FriendsListItem extends StatelessWidget {
  const FriendsListItem({Key? key}) : super(key: key);

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

            const Text(
              'Mohit Kr',
              style: Styles.itemText,
            ),
            const Text('11-8-1994', style: Styles.itemText),
            const Text('8:30', style: Styles.itemText),
            const Text('Brother', style: Styles.itemText),
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
