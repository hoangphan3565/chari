
import 'dart:convert';

import 'package:charity_donator_app/API.dart';
import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/models/models.dart';
import 'package:charity_donator_app/screens/screens.dart';
import 'package:charity_donator_app/utility/utility.dart';
import 'package:charity_donator_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class PersonalScreen extends StatefulWidget {
  final Donator donator;
  PersonalScreen({Key key, @required this.donator}) : super(key: key);
  @override
  _PersonalScreenState createState()=> _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {

  String fullname;
  String address;

  initState() {
    _getDonatorDetails();
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  _getDonatorDetails() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      fullname=_prefs.getString('donator_full_name');
      address=_prefs.getString('donator_address');
    });
  }

  _validateAndChangePassword(String username, String cur_password,String new_password1,String new_password2){
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
    if(new_password1.length < 6 || !Validate.validatePassword(new_password1)){
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
    _changePassword(username, cur_password, new_password1, new_password2);
  }

  _changePassword(String username, String cur_password,String new_password1,String new_password2) async{
    String url = baseUrl+"/change/password";
    final body = jsonEncode(<String, String>{
      "username":username,
      "cur_password":cur_password,
      "password1":new_password1,
      "password2":new_password2,
      "user_type":"Donator"
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
    //Kiem tra API Status - 200 tức là đổi thành công - theo như mô tả từ server.
    if(res.statusCode == 200){
      // lưu mật khẩu mới vào SharedPreferences
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('password',jsonResponse['data']['password']);
      //Đóng dialog khi đổi mật khẩu thành công
      Navigator.pop(context);
    }
  }

  _updateInformation(int id, String fullname, String address) async{
    String url = baseUrl+donators+"/update/id/"+id.toString();
    final body = jsonEncode(<String, String>{
      "fullName": fullname,
      "address": address,
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
    //Kiem tra API Status - 200 tức là đổi thành công - theo như mô tả từ server.
    if(res.statusCode == 200){
      // lưu thông tin mới được cập nhật vào SharedPreferences
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      setState(() {
        _prefs.setString('donator_full_name',jsonResponse['data']['fullName']);
        _prefs.setString('donator_address',jsonResponse['data']['address']);
        this.fullname=_prefs.getString('donator_full_name');
        this.address=_prefs.getString('donator_address');
      });
      //Đóng dialog khi cập nhật thành công
      Navigator.pop(context);
    }
  }

  _showChangePasswordDialog(BuildContext context) {
    TextEditingController _curPasswordField = TextEditingController();
    TextEditingController _newPasswordField = TextEditingController();
    TextEditingController _reWritePasswordField = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 2.4,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text("Đổi mật khẩu",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[600],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 1.5,
                      color: Colors.grey[300],
                      margin: EdgeInsets.symmetric(horizontal: 0),
                    ),
                    SizedBox(height: 5),
                    RoundedPasswordField(
                      hintText: "Mật khẩu hiện tại",
                      icon: LineAwesomeIcons.alternate_unlock,
                      obscureText: true,
                      controller: _curPasswordField,
                      onChanged: (value) {},
                    ),
                    RoundedPasswordField(
                      hintText: "Mật khẩu mới",
                      icon: LineAwesomeIcons.lock_open,
                      obscureText: true,
                      controller: _newPasswordField,
                      onChanged: (value) {},
                    ),
                    RoundedPasswordField(
                      hintText: "Nhập lại mật khẩu mới",
                      icon: LineAwesomeIcons.lock,
                      obscureText: true,
                      controller: _reWritePasswordField,
                      onChanged: (value) {},
                    ),

                    RoundedButton(
                      text: "Xác nhận",
                      press: ()async{
                        SharedPreferences _prefs = await SharedPreferences.getInstance();
                        _validateAndChangePassword(_prefs.getString('username'),_curPasswordField.text,_newPasswordField.text,_reWritePasswordField.text);
                      },
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }

  _showChangeInformationDialog(BuildContext context) {
    TextEditingController _fullnameField = TextEditingController(text: fullname);
    TextEditingController _addressField = TextEditingController(text: address);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 3,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text("Cập nhật thông tin cá nhân",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[600],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 1.5,
                      color: Colors.grey[300],
                      margin: EdgeInsets.symmetric(horizontal: 0),
                    ),
                    SizedBox(height: 5),
                    RoundedInputField(
                      icon: Icons.person,
                      keyboardType: TextInputType.name,
                      controller: _fullnameField,
                      onChanged: (value) {},
                    ),
                    RoundedInputField(
                      icon: LineAwesomeIcons.address_card,
                      keyboardType: TextInputType.streetAddress,
                      controller: _addressField,
                      onChanged: (value) {},
                    ),

                    RoundedButton(
                      text: "Xác nhận",
                      press: ()async{
                        SharedPreferences _prefs = await SharedPreferences.getInstance();
                        _updateInformation(_prefs.getInt('donator_id'),_fullnameField.text,_addressField.text);
                      },
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Trang cá nhân',
          style: const TextStyle(
            color: kPrimaryLightColor,
            fontSize: 27.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.7,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(),
          Expanded(
            child: SingleChildScrollView(
              child:  Column(
                  children: [
                    SizedBox(height: kSpacingUnit.toDouble() * 2),
                    Container(
                      height: kSpacingUnit.toDouble() * 18,
                      width: kSpacingUnit.toDouble() * 18,
                      margin: EdgeInsets.only(top: kSpacingUnit.toDouble() * 3),
                      child: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            radius: kSpacingUnit.toDouble() * 15,
                            backgroundImage: NetworkImage(widget.donator.avatar_url)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: kSpacingUnit.toDouble() * 2),
                    Text(
                      this.fullname == null ? '' : this.fullname,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: kSpacingUnit.toDouble() * 0.5),
                    Text(
                      widget.donator.phone_number,
                      style: kCaptionTextStyle,
                    ),
                    SizedBox(height: kSpacingUnit.toDouble() * 5),
                    RoundedButton(
                      text: 'Đóng góp ý kiến',
                      fontsize: 17,
                      press: ()=>{print('Đóng góp ý kiến')},
                    ),
                    RoundedButton(
                      text: 'Cập nhật thông tin',
                      fontsize: 17,
                      press: ()=>{
                        _showChangeInformationDialog(context)
                      },
                    ),
                    RoundedButton(
                      text: 'Đổi mật khẩu',
                      fontsize: 17,
                      press: ()=>{
                        _showChangePasswordDialog(context)
                      },
                    ),
                    RoundedButton(
                      text: 'Đăng xuất',
                      fontsize: 17,
                      press: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext ctx) => AppBarScreen()));
                      },
                    ),
                  ]
              )
            ),
          ),
        ],
      ),
    );
  }
}