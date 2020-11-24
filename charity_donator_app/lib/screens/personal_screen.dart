import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:charity_donator_app/Screens/home_screen.dart';
import 'package:charity_donator_app/Screens/signup_screen.dart';
import 'package:charity_donator_app/components/background.dart';
import 'package:charity_donator_app/components/profile_list_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

import 'package:charity_donator_app/components/already_have_an_account_acheck.dart';
import 'package:charity_donator_app/components/rounded_button.dart';
import 'package:charity_donator_app/components/rounded_input_field.dart';
import 'package:charity_donator_app/components/rounded_password_field.dart';
import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/API.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';



class PersonalScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  backgroundImage: NetworkImage('https://webbachthang.com/wp-content/uploads/2017/12/avatar-la-gi-01.jpg'),
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
            'Tên gì gì đó',
             style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.toDouble() * 0.5),
          Text(
            'Số điện thoại nè',
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.toDouble() * 5),
          SizedBox(height: kSpacingUnit.toDouble() * 5),
          ProfileListItem(
            icon: LineAwesomeIcons.question_circle,
            text: 'Yêu cầu hỗ trợ',
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.comment_dots,
            text: 'Đóng góp ý kiến',
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.user_edit,
            text: 'Thay đổi thông tin cá nhân',
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.alternate_sign_out,
            text: 'Đăng xuất',
            hasNavigation: false,
          ),
        ],
      ),
    );
  }
}