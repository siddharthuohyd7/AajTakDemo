import 'package:aajtak/ui/add_new_profile.dart';
import 'package:aajtak/ui/friends_family_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aaj tak',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),

        primarySwatch: Colors.blue,

      ),
      initialRoute: '/home',
      routes: {
        '/home': (BuildContext context) => const FriendsFamilyScreen(),
        '/AddNewProfile': (BuildContext context) => const AddNewProfile(),

      },
    );
  }
}

