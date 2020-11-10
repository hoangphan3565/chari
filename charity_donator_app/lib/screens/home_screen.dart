import 'package:charity_donator_app/components/background.dart';
import 'package:charity_donator_app/components/rounded_input_field.dart';
import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/components/rounded_button.dart';
import 'package:charity_donator_app/API.dart';


import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:percent_indicator/percent_indicator.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState()=> _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  TextEditingController _searchController = TextEditingController();


  testGetDataWithToken() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get("jwt");
    if(token == null){
      print('chuyển hướng đến trang đăng nhập');
      return;
    }
    else{
      String url = baseUrl+projects+"/test";
      var jsonResponse;
      final res = await http.get(url, headers:getHeaderJWT(token));
      jsonResponse = json.decode(res.body);
      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");
    }
  }

  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Danh sách bài viết
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 8),
                children: [
                  TextField(
                    controller: _searchController,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: kPrimaryColor,
                      ),
                      hintText: "Tìm kiếm",
                      border: InputBorder.none,
                    ),
                  ),
                  buildPostSection(
                      "https://hieuvetraitim.com/attachments/hoan-canh-gioi-thieu-jpg.1782/",
                      "Tên của một dự án, hoàn cảnh khó khăn, gì đó,.... ",
                      "Nội dung vắn tắt của hoàn cảnh khó khăn cần được hỗ trợ, Nội dung vắn tắt của hoàn cảnh khó khăn cần được hỗ trợ",
                      "100.000",50,5000000,7000000),
                  buildPostSection(
                      "https://lh3.googleusercontent.com/proxy/G_rQiHWDaJmB1yVTbbBg0sBFC7wXsXp2rT9PQGdjOQaotzWAmqyj4xza6IoerqPgTy43zxJYjh3eJsNHv9cz99MTqED_WiwKEwJbSre5_a8KSQgpheT5-rC8vlVW0WsP",
                      "Day la ten cua du an 2",
                      "Day la noi dung van tat cua du an, Day la noi dung van tat cua du an, Day la noi dung van tat cua du an ",
                      "100.000",30,6000000,7000000),
                  buildPostSection(
                      "https://loisusong.net/wp-content/uploads/2019/01/Tu-thien-tai-Son-La-5.jpg",
                      "Day la ten cua du an 3",
                      "Day la noi dung van tat cua du an, Day la noi dung van tat cua du an, Day la noi dung van tat cua du an ",
                      "100.000",100,6800000,7000000),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.1),
                spreadRadius: 1,
              )
            ],
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            buildNavBarItem(Icons.home, 0),
            buildNavBarItem(Icons.favorite, 1),
            buildNavBarItem(Icons.notifications, 2),
            buildNavBarItem(Icons.history, 3),
            buildNavBarItem(Icons.person, 4),
          ],
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 45,
        child: icon != null
            ? Icon(
          icon,
          size: 25,
          color: index == _selectedItemIndex
              ? Colors.green[800]
              : Colors.green[400],
        )
            : Container(),
      ),
    );
  }

  Container buildPostSection(String urlPost, String projectName,String briefInformation, String numOfDonations,int remainingTerm,int curMoney,int targetMoney) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPostPicture(urlPost),  //Hình ảnh mặc định của bài viết
          SizedBox(
            height: 10,
          ),
          //Tên dự án
          Text(
            projectName,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          //Thông tin vắn tắt
          Text(
            briefInformation,
            style: TextStyle(
                fontSize: 15,
                color: Colors.black26),
          ),
          SizedBox(
            height: 5,
          ),
          //Dấu phân tách
          Container(
            height: 1.5,
            color: Colors.grey[300],
            margin: EdgeInsets.symmetric(horizontal: 0),
          ),
          SizedBox(
            height: 5,
          ),
          buildProgressPercentRow(curMoney,targetMoney),
          SizedBox(
            height: 5,
          ),
          buildInfoDetailsRow(numOfDonations,remainingTerm),
        ],
      ),
    );
  }

  Stack buildPostPicture(String urlPost) {
    return Stack(
      children: [
        InkWell(
          onTap: ()=>{
            print("test!!!")
          },
          child: Container(
            height: MediaQuery.of(context).size.width - 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(urlPost),
                )),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Icon(Icons.favorite, size: 35, color: Colors.white.withOpacity(0.7)),
        )
      ],
    );
  }

  Row buildInfoDetailsRow(String numOfDonations,int remainingTerm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lượt quyên góp",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                Text(
                  numOfDonations,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thời hạn còn",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                Text(
                  remainingTerm.toString()+" Ngày",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            )
          ],
        ),
        Container(
          width: 125,
          height: 40,
          decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.green[600]),
          borderRadius: BorderRadius.circular(10), color: kPrimaryLightColor),
          child:FlatButton(
            onPressed:()=> {},
            child: Text(
              "Quyên góp",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[600]),
            ),
          ),
        ),
      ],
    );
  }

  Row buildProgressPercentRow(int curMoney,int targetMoney) {
    return Row(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Đã quyên góp được "+curMoney.toString()+" đ / "+targetMoney.toString()+" đ",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width-60,
                lineHeight: 8.0,
                percent: curMoney/targetMoney,
                progressColor: Colors.green[600],
              ),
            ],
          )
        ]);
  }


}
