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

class LoginScreen extends StatefulWidget {
  @override
    _LoginScreenState createState()=> _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool notSeePassword = true;
  _validateAndLogin(String username, String password){
    String error_message='';
    if(username.length != 0 && password.length !=0) {
      if(username.length==10 && CheckString.onlyNumber(username)){
        if(CheckString.isMyCustomPassword(password)){
          _logIn(username, password);
        }else{
          error_message='Sai SĐT hoặc mật khẩu!';
        }}else{
        error_message='Sai SĐT hoặc mật khẩu!';
      }}else{
      error_message='Không được trống thông tin nào!';
    }
    if(error_message.length>0){
      Fluttertoast.showToast(
          msg: error_message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  _logIn(String username, String password) async{
    String url = baseUrl+login;
    final body = jsonEncode(<String, String>{
      "username":username,
      "password":password,
    });
    var jsRes;
    var res = await http.post(url,headers:header,body: body);
    jsRes = json.decode(utf8.decode(res.bodyBytes));
    //Kiem tra API Status
    if(res.statusCode == 200) {
      //Khi Đăng nhập với quyền ko phải là Donator
      if(jsRes['data']['usertype']!="Donator"){
        Fluttertoast.showToast(
            msg: 'Không thể đăng nhập',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return;
      }else{
        // lưu token vào SharedPreferences
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString('username',jsRes['data']['username']);
        _prefs.setString('password',jsRes['data']['password']);

        // Lưu thông tin người dùng đã đăng nhập... Vì lúc tạo người dùng mới, app đang dùng là app của donator, phía server sẽ lưu đồng thời cả app user và thông tin của donator,
        // lúc đăng ký lần đầu thì thông tin của donator chỉ có mỗi số điện thoại
        var jsRes2;
        var res2 = await http.get(baseUrl + donators +"/phone/"+username,headers:header);
        jsRes2 = json.decode(utf8.decode(res2.bodyBytes));
        _prefs.setInt('donator_id',jsRes2['dnt_ID']);
        if(jsRes2['address']==null){_prefs.setString('donator_address','');
        }else{_prefs.setString('donator_address',jsRes2['address'].toString());
        }if(jsRes2['fullName']==null){_prefs.setString('donator_full_name','');
        }else{_prefs.setString('donator_full_name',jsRes2['fullName'].toString());
        }if(jsRes2['avatarUrl']==null){_prefs.setString('donator_avatar_url','https://1.bp.blogspot.com/-kFguDxc0qe4/XyzyK1y6eiI/AAAAAAAAwW8/XcAuOQ2qvQYhoDe4Bv0eLX9eye7FnmKKgCLcBGAsYHQ/s1600/co-4-la%2B%25283%2529.jpg');
        }else{_prefs.setString('donator_avatar_url',jsRes2['avatarUrl'].toString());
        }
        _prefs.setString('donator_phone',jsRes2['phoneNumber'].toString());
        _prefs.setString('donator_favorite_project',jsRes2['favoriteProject'].toString());

        //Chuyển hướng đến trang chính và xóa tất cả context trước đó
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> AppBarScreen()), (Route<dynamic> route) => false);
      }
    }
    Fluttertoast.showToast(
        msg: jsRes['messenger'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: jsRes['errorCode'] == 0 ? Colors.green:Colors.orangeAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
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
                  onTopClearIcon: ()=>{_usernameController.clear()},
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  hintText: "Nhập mật khẩu",
                  obscureText: notSeePassword,
                  icon: LineAwesomeIcons.lock,
                  controller: _passwordController,
                  onTapSuffixIcon: ()=>{
                    if(notSeePassword==true){
                      setState((){notSeePassword=false;})
                    }else{
                      setState((){notSeePassword=true;})
                    }
                  },
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: "Đăng nhập",
                  press: (){
                    _validateAndLogin(_usernameController.text,_passwordController.text);
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext ctx) => SignUpScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}
