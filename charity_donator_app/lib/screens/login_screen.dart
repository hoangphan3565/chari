import 'dart:convert';

import 'package:charity_donator_app/API.dart';
import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/screens/screens.dart';
import 'package:charity_donator_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    String url = baseUrl+login;
    final body = jsonEncode(<String, String>{
      "username":username,
      "password":password
    });
    var jsonResponse;
    var res = await http.post(url,headers:header,body: body);
    //Kiem tra API Status
    if(res.statusCode == 200){
      jsonResponse = json.decode(res.body);
      if(jsonResponse != null){
        setState(() {
          _isLoading = false;
        });
        // lưu token vào SharedPreferences
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString('username',jsonResponse['data']['username']);
        _prefs.setString('password',jsonResponse['data']['password']);

        // Lưu thông tin người dùng đã đăng nhập
        var jsonResponse2;
        var res2 = await http.get(baseUrl + donators +"/phone/"+username,headers:header);
        jsonResponse2 = json.decode(res2.body);
        _prefs.setInt('donator_id',jsonResponse2['dnt_ID']);
        _prefs.setString('donator_address',jsonResponse2['address']);
        _prefs.setString('donator_avatar_url',jsonResponse2['avatarUrl']);
        _prefs.setString('donator_full_name',jsonResponse2['fullName']);
        _prefs.setString('donator_favorite_project',jsonResponse2['favoriteProject']);

        //Hiện thông báo đăng nhập thành công
        Fluttertoast.showToast(
            msg: "Đăng nhập thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        //Chuyển hướng đến trang chính và xóa tất cả context trước đó
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> MainScreen()), (Route<dynamic> route) => false);
      }
    }
    else{
      Fluttertoast.showToast(
          msg: "Sai SĐT hoặc mật khẩu",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
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
                  icon: LineAwesomeIcons.phone,
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
                  press: (){
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
