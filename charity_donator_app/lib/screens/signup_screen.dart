import 'package:charity_donator_app/Screens/login_screen.dart';
import 'package:charity_donator_app/components/background.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:charity_donator_app/API.dart';
import 'package:charity_donator_app/components/already_have_an_account_acheck.dart';
import 'package:charity_donator_app/components/rounded_button.dart';
import 'package:charity_donator_app/components/rounded_input_field.dart';
import 'package:charity_donator_app/components/rounded_password_field.dart';
import 'package:charity_donator_app/constants.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState()=> _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _password1Controller = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  bool _isLoading = false;

  //Hàm xử lý đăng ký bằng API
  singUp(String username, String password1,String password2) async{
    String url = baseUrl+register;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final body = jsonEncode(<String, String>{
      "username":username,
      "password1":password1,
      "password2":password2,
      "usertype":"Donator"
    });
    var jsonResponse;
    var res = await http.post(url,headers:header,body: body);
    //Kiem tra API Status
    if(res.statusCode == 200){
      jsonResponse = json.decode(res.body);
      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");
      if(jsonResponse != null){
        setState(() {
          _isLoading = false;
        });
        //Chuyển hướng đến trang chính và xóa tất cả context trước đó
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()), (Route<dynamic> route) => false);
      }
    }else{
      setState(() {
        _isLoading = false;
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
                "Đăng ký",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/icons/signup.png",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Nhập Số điện thoại",
                icon: Icons.phone,
                keyboardType: TextInputType.number,
                controller: _usernameController,
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                hintText: "Nhập mật khẩu",
                controller: _password1Controller,
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                hintText: "Nhập lại mật khẩu",
                controller: _password2Controller,
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "Đăng ký",
                press:(){
                  setState(() {
                    _isLoading = true;
                  });
                  singUp(_usernameController.text,_password1Controller.text,_password2Controller.text);
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()), (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
