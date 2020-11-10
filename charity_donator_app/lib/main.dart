import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/screens/home_screen.dart';
import 'package:charity_donator_app/screens/login_screen.dart';
import 'package:charity_donator_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: HomeScreen()
    );
  }
}