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


  _logIn(String username, String password) async{
    String url = baseUrl+login;
    final body = jsonEncode(<String, String>{
      "username":username,
      "password":password
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
    if(res.statusCode == 200) {
      // lưu token vào SharedPreferences
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('username',jsonResponse['data']['username']);
      _prefs.setString('password',jsonResponse['data']['password']);

      // Lưu thông tin người dùng đã đăng nhập... Vì lúc tạo người dùng mới, app đang dùng là app của donator, phía server sẽ lưu đồng thời cả app user và thông tin của donator,
      // lúc đăng ký lần đầu thì thông tin của donator chỉ có mỗi số điện thoại
      var jsonResponse2;
      var res2 = await http.get(baseUrl + donators +"/phone/"+username,headers:header);
      jsonResponse2 = json.decode(utf8.decode(res2.bodyBytes));
      _prefs.setInt('donator_id',jsonResponse2['dnt_ID']);
      if(jsonResponse2['address']==null){
        _prefs.setString('donator_address','');
      }
      else{
        _prefs.setString('donator_address',jsonResponse2['address'].toString());
      }
      if(jsonResponse2['fullName']==null){
        _prefs.setString('donator_full_name','Nhà hảo tâm');
      }
      else{
        _prefs.setString('donator_full_name',jsonResponse2['fullName'].toString());
      }
      if(jsonResponse2['avatarUrl']==null){
        _prefs.setString('donator_avatar_url','https://1.bp.blogspot.com/-kFguDxc0qe4/XyzyK1y6eiI/AAAAAAAAwW8/XcAuOQ2qvQYhoDe4Bv0eLX9eye7FnmKKgCLcBGAsYHQ/s1600/co-4-la%2B%25283%2529.jpg');
      }
      else{
        _prefs.setString('donator_avatar_url',jsonResponse2['avatarUrl'].toString());
      }
      _prefs.setString('donator_phone',jsonResponse2['phoneNumber'].toString());
      _prefs.setString('donator_favorite_project',jsonResponse2['favoriteProject'].toString());

      //Chuyển hướng đến trang chính và xóa tất cả context trước đó
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> AppBarScreen()), (Route<dynamic> route) => false);
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
                  obscureText: true,
                  icon: LineAwesomeIcons.lock,
                  controller: _passwordController,
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: "Đăng nhập",
                  press: (){
                    _logIn(_usernameController.text,_passwordController.text);
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
