import 'dart:convert';

import 'package:charity_donator_app/API.dart';
import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/screens/screens.dart';
import 'package:charity_donator_app/utility/utility.dart';
import 'package:charity_donator_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState()=> _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _password1Controller = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  _validateAndLogin(String username, String password1,String password2){
    if(username.length!=10){
      Fluttertoast.showToast(
          msg: 'Số điện thoại không chính xác',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }
    if(password1.length < 6 || !Validate.validatePassword(password1)){
      Fluttertoast.showToast(
          msg: 'Mật khẩu phải có ít nhất 6 ký tự, chứa ký tự in hoa, số và ký tự đặc biệt!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }
    _singUp(username, password1, password2);
  }

  //Hàm xử lý đăng ký bằng API
  _singUp(String username, String password1,String password2) async{
    String url = baseUrl+register;
    final body = jsonEncode(<String, String>{
      "username":username,
      "password1":password1,
      "password2":password2,
      "usertype":"Donator"
    });
    var jsonResponse;
    var res = await http.post(url,headers:header,body: body);
    jsonResponse = json.decode(utf8.decode(res.bodyBytes));
    //Hiện thông báo theo messenge được trả về từ server
    Fluttertoast.showToast(
        msg: jsonResponse['messenger'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    //Kiem tra API Status
    if(res.statusCode == 200){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()), (Route<dynamic> route) => false);
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
                icon: LineAwesomeIcons.phone,
                keyboardType: TextInputType.number,
                controller: _usernameController,
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                hintText: "Nhập mật khẩu",
                icon: LineAwesomeIcons.lock,
                obscureText: true,
                controller: _password1Controller,
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                hintText: "Nhập lại mật khẩu",
                icon: LineAwesomeIcons.lock_open,
                obscureText: true,
                controller: _password2Controller,
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "Đăng ký",
                press:(){
                  _validateAndLogin(_usernameController.text,_password1Controller.text,_password2Controller.text);
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
