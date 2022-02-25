import 'package:aajtak/providers/refresh_event_provider.dart';
import 'package:aajtak/ui/add_new_profile.dart';
import 'package:aajtak/ui/friends_family_screen.dart';
import 'package:aajtak/ui/places_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/relatives_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RefreshProviderEvent>(
      create: (_) => RefreshProviderEvent(),
      child: MaterialApp(
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
          '/AddNewProfile': (BuildContext context) => AddNewProfile(
              relative:
                  ModalRoute.of(context)?.settings.arguments as Relative?),
          '/Places': (BuildContext context) => const PlacesSearchScreen()
        },
      ),
    );
  }
}
