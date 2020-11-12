import 'package:charity_donator_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:charity_donator_app/components/background.dart';
import 'package:charity_donator_app/components/rounded_input_field.dart';
import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/components/rounded_button.dart';
import 'package:charity_donator_app/API.dart';
import 'package:charity_donator_app/models/Project.dart';


import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' show utf8;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:unicode/unicode.dart' as unicode;

class ProjectDetailsScreen extends StatefulWidget {
  //ProjectDetailsScreen({Key key}) : super(key: key);
  final int id;
  ProjectDetailsScreen({@required this.id});
  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  var project = new  List<Project>();
  bool _isLoading = false;

  String project_name;
  String image_url;
  String video_url;
  String brief_description;
  String description;
  int num_of_donations;
  int remaining_term;
  int cur_money;
  int target_money;

  @override
  void initState() {
    _getProjectDetails(widget.id).then((value){
      print('Async done');
    });
    super.initState();
  }

  Future _getProjectDetails(int id) async{
    API.getProjectDetails(id).then((response) {
      setState(() {
        List<dynamic> list = json.decode(utf8.decode(response.bodyBytes));
        project = list.map((model) => Project.fromJson(model)).toList();
        project_name=project[0].project_name;
        image_url=project[0].image_url;
        video_url=project[0].video_url;
        brief_description=project[0].brief_description;
        description = project[0].description;
        num_of_donations=project[0].num_of_donations;
        remaining_term=project[0].remaining_term;
        cur_money=project[0].cur_money;
        target_money=project[0].target_money;
      });
    });
  }

  int _selectedItem0 = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 35),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back)),
                Icon(Icons.more_vert),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 5, right: 5, top: 8),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(15))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildPostVideo(widget.id,video_url),                //Video giới thiệu của bài viết
                    SizedBox(height: 8),
                    buildProjectInfo(project_name,brief_description),   //Thông tin vắn tắt
                    buildProjectDetails(description,num_of_donations,remaining_term,cur_money,target_money),
                  ],
                ),
              ),
            ),
          )
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            child: Image.asset(
              "assets/icons/donate.png",
              height: 40,
              width: 40,
            ),
            backgroundColor: Colors.green[500],
            elevation: 15,
          ),
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
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            buildNavBarItem(null, -1),
          ],
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItem0 = 0;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 45,
        child: icon != null
            ? Icon(
          icon,
          size: 25,
          color: 0 == _selectedItem0
              ? Colors.green[800]
              : Colors.green[400],
        )
            : Container(),
      ),
    );
  }


  // Card buildPictureCard(String url) {
  //   //   return Card(
  //   //     elevation: 10,
  //   //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //   //     child: Container(
  //   //       decoration: BoxDecoration(
  //   //           borderRadius: BorderRadius.circular(30),
  //   //           image: DecorationImage(
  //   //             fit: BoxFit.cover,
  //   //             image: NetworkImage(url),
  //   //           )),
  //   //     ),
  //   //   );
  //   // }
  // Column buildStatColumn(String value, String title) {
  //   return Column(
  //     children: [
  //       Text(
  //         value,
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       Text(
  //         title,
  //         style: TextStyle(
  //           fontSize: 12,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.grey[400],
  //         ),
  //       ),
  //     ],
  //   );
  // }


  // Container buildPostSection(int id,String video_url, String projectName,String briefInformation,String information, int numOfDonations,int remainingTerm,int curMoney,int targetMoney) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 8),
  //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //     decoration: BoxDecoration(
  //       color: Colors.grey.withOpacity(0.1),
  //       borderRadius: BorderRadius.circular(15),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         buildPostVideo(id,video_url),  //Video gioi thieu của bài viết
  //         SizedBox(
  //           height: 10,
  //         ),
  //         //Tên dự án
  //         Text(
  //           projectName,
  //           style: TextStyle(
  //               fontSize: 17,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black),
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         //Thông tin vắn tắt
  //         Text(
  //           briefInformation,
  //           style: TextStyle(
  //               fontSize: 15,
  //               color: Colors.black26),
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         //Dấu phân tách
  //         Container(
  //           height: 1.5,
  //           color: Colors.grey[300],
  //           margin: EdgeInsets.symmetric(horizontal: 0),
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         buildProgressPercentRow(curMoney,targetMoney),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         buildInfoDetailsRow(numOfDonations,remainingTerm,curMoney,targetMoney),
  //       ],
  //     ),
  //   );
  // }


  Stack buildPostVideo(int id,String image_url) {
    return Stack(
      children: [
        InkWell(
          child: Container(
            height: MediaQuery.of(context).size.width - 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
                  image: NetworkImage(image_url),
                )),
          ),
        ),
      ],
    );
  }

  Container buildProjectInfo(String projectName,String briefInformation){
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                color: Colors.black54),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Container buildProjectDetails(String description,int numOfDonations,int remainingTerm,int curMoney,int targetMoney){
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProgressPercentRow(curMoney,targetMoney),
          SizedBox(height: 10),
          buildInfoDetailsRow(numOfDonations,remainingTerm,curMoney,targetMoney),
          SizedBox(height: 20),
          Container(
            height: 1,
            color: Colors.grey[300],
            margin: EdgeInsets.symmetric(horizontal: 0),
          ),
          SizedBox(height: 20),
          Text(
            "Thông tin",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
                fontSize: 14,
                color: Colors.black),
          ),
          SizedBox(height: 20),
          Container(
            height: 1,
            color: Colors.grey[300],
            margin: EdgeInsets.symmetric(horizontal: 0),
          ),
          SizedBox(height: 20),
          Text(
            "Hình ảnh",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ],
      ),
    );
  }


  Row buildInfoDetailsRow(int numOfDonations,int remainingTerm,int curMoney,int targetMoney) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Lượt quyên góp",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                Text(
                  numOfDonations.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              width: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đạt được",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                Text(
                  (curMoney/targetMoney*100).round().toString()+" %",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              width: 40,
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
                width: MediaQuery.of(context).size.width-35,
                lineHeight: 8.0,
                percent: curMoney/targetMoney,
                progressColor: Colors.green[600],
              ),
            ],
          )
        ]);
  }
}