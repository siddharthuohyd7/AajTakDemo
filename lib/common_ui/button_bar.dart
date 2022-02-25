
import 'package:aajtak/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonTabBar extends StatelessWidget {
  final List<String> tabTitles;
  final Function(String title) ? callback;

   ButtonTabBar({Key? key, required this.tabTitles,required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Material(
        color: Colors.white,
        elevation: 3,
        child: TabBar(

          onTap: (value){
            if(callback!=null) {
              callback!(tabTitles[value]);
            }
          },
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          labelStyle: Styles.tabText,
          unselectedLabelColor: Colors.black45,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              5.0,
            ),
            color: Colors.indigo,
          ),
          tabs: [
            ...tabTitles.map((tabTitle) {
              return Tab(
                text: tabTitle,

              );
            })
          ],
        ),
      ),
    );
  }
}
