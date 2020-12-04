
import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/screens/screens.dart';
import 'package:charity_donator_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PersonalScreen extends StatefulWidget {
  @override
  _PersonalScreenState createState()=> _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  bool islogin = false;
  String fullname;
  int donator_id;
  String address;
  String avatar_url;
  String phone;

  initState() {
    super.initState();
    _checkLogin();
  }

  dispose() {
    super.dispose();
  }
  _checkLogin() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    setState(() {
      if(username==null) {
        islogin=false;
      }else{
        islogin=true;
        fullname = prefs.getString('donator_full_name');
        donator_id = prefs.getInt('donator_id');
        address = prefs.getString('donator_address');
        phone = prefs.getString('donator_phone');
        avatar_url = prefs.getString('donator_avatar_url');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              islogin == false ?
              Column(children: [
                SizedBox(height: kSpacingUnit.toDouble() * 30),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Center(
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
                              },
                              child: Text('Đăng nhập'),
                            )
                          ),
                        ),
                      ),
                    ],
                ),
              ])
              :
              Column(
              children: [
                SizedBox(height: kSpacingUnit.toDouble() * 5),
                Container(
                  height: kSpacingUnit.toDouble() * 15,
                  width: kSpacingUnit.toDouble() * 15,
                  margin: EdgeInsets.only(top: kSpacingUnit.toDouble() * 3),
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: kSpacingUnit.toDouble() * 15,
                        backgroundImage: NetworkImage(avatar_url),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: kSpacingUnit.toDouble() * 2.5,
                          width: kSpacingUnit.toDouble() * 2.5,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            heightFactor: kSpacingUnit.toDouble() * 1.5,
                            widthFactor: kSpacingUnit.toDouble() * 1.5,
                            child: Icon(
                              LineAwesomeIcons.pen,
                              color: kPrimaryLightColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: kSpacingUnit.toDouble() * 2),
                Text(
                  fullname,
                  style: kTitleTextStyle,
                ),
                SizedBox(height: kSpacingUnit.toDouble() * 0.5),
                Text(
                  phone,
                  style: kCaptionTextStyle,
                ),
                SizedBox(height: kSpacingUnit.toDouble() * 5),
                SizedBox(height: kSpacingUnit.toDouble() * 5),
                ProfileListItem(
                  icon: LineAwesomeIcons.question_circle,
                  text: 'Yêu cầu hỗ trợ',
                  press: ()=>{print('Yêu cầu hỗ trợ')},
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.comment_dots,
                  text: 'Đóng góp ý kiến',
                  press: ()=>{print('Đóng góp ý kiến')},
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.user_edit,
                  text: 'Cập nhật thông tin',
                  press: ()=>{print('Cập nhật thông tin')},
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.alternate_sign_out,
                  text: 'Đăng xuất',
                  press: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext ctx) => MainScreen()));
                  },
                  hasNavigation: false,
                ),
              ]
              )]),
          ),
        ],
      ),
    );
  }
}