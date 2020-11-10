import 'package:charity_collaborator_app/components/background.dart';
import 'package:charity_collaborator_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:charity_collaborator_app/constants.dart';
import 'package:charity_collaborator_app/components/rounded_button.dart';
import 'package:charity_collaborator_app/restart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeScreen extends StatelessWidget {

  void _logout()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("token");
    await preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Trang chính của Chari",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Image.asset(
                "assets/images/handsake.png",
                height: size.height * 0.45,
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                text: "Đăng xuất",
                press: () {
                  _logout();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> WelcomeScreen()), (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
