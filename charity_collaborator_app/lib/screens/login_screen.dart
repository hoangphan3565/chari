import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:charity_collaborator_app/components/background.dart';
import 'package:charity_collaborator_app/screens/home_screen.dart';
import 'package:charity_collaborator_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charity_collaborator_app/components/already_have_an_account_acheck.dart';
import 'package:charity_collaborator_app/components/rounded_button.dart';
import 'package:charity_collaborator_app/components/rounded_input_field.dart';
import 'package:charity_collaborator_app/components/rounded_password_field.dart';
import 'package:charity_collaborator_app/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:http/http.dart' as http;




class LoginScreen extends StatefulWidget {
  @override
    _LoginScreenState createState()=> _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoginFailed = false;
  bool _isLoading = false;

  //Hàm xử lý đăng nhập bằng API
  logIn(String username, String password) async{
    String url = "http://10.0.2.2:8080/api/login";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final body = jsonEncode(<String, String>{
      "username":username,
      "password":password
    });
    var jsonResponse;
    var res = await http.post(url,headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},body: body);
    //Kiem tra API Status
    if(res.statusCode == 200){
      jsonResponse = json.decode(res.body);
      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");
      if(jsonResponse != null){
        setState(() {
          _isLoading = false;
        });
        // lưu token vào sharedPreferences
        sharedPreferences.setString("token", jsonResponse['token']);
        //Chuyển hướng đến trang chính và xóa tất cả context trước đó
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> HomeScreen()), (Route<dynamic> route) => false);
      }
    }else{
      setState(() {
        _isLoading = false;
        _isLoginFailed = true;
      });
      print("Response body: ${res.body}");
    }
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
                  "Đăng nhập",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  "assets/icons/login.png",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "Nhập Số điện thoại",
                  icon: Icons.phone,
                  keyboardType: TextInputType.number,
                  controller: _usernameController,
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  hintText: "Nhập mật khẩu",
                  controller: _passwordController,
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: "Đăng nhập",
                  press: _usernameController.text == "" || _passwordController.text == ""
                  ? null
                  :(){
                    setState(() {
                      _isLoading = true;
                    });
                    logIn(_usernameController.text,_passwordController.text);
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> SignUpScreen()), (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}
