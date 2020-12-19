import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:charity_donator_app/API.dart';
import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/models/project_model.dart';
import 'package:charity_donator_app/screens/screens.dart';
import 'package:charity_donator_app/utility/utility.dart';
import 'package:charity_donator_app/widgets/custom_alert_dialog.dart';
import 'package:charity_donator_app/widgets/widgets.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class ProjectDetailsScreen extends StatefulWidget {
  final Project project;
  ProjectDetailsScreen({@required this.project});
  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  TextEditingController _moneyControllerField = TextEditingController();
  TextEditingController _messageControllerField = TextEditingController();

  List<String> listProjectIdFavorite = new List<String>();

  String donate_money="";


  @override
  void initState() {
    super.initState();
    this.initializePlayer(widget.project.video_url);
  }

  @override
  void dispose() {
    super.dispose();
    this._videoPlayerController.dispose();
  }

  Future<void> initializePlayer(String video_url) async {
    _videoPlayerController = VideoPlayerController.network(video_url);
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true,
    );
    setState(() {});
  }

  _showDonateDialog(BuildContext context,Project project) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 2.2,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(project.project_name,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 1.5,
                      color: Colors.grey[300],
                      margin: EdgeInsets.symmetric(horizontal: 0),
                    ),
                    SizedBox(height: 10),
                    Text("Phương thức thanh toán"),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.paypal), onPressed: () {  },
                      color: Colors.blueAccent,
                      iconSize: 40,
                    ),
                    TextField(
                      controller: _moneyControllerField,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        print(value);
                        this.donate_money=value;
                      },
                      decoration: InputDecoration(
                        labelText: "Số tiền*: ${MoneyUtility.numberToString(this.donate_money)}",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _messageControllerField,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        labelText: "Lời nhắn",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    RoundedButton(
                      text: "Ủng hộ",
                      press: ()async{
                        int lessMoney=project.target_money-project.cur_money;
                        String message="";
                        if(_moneyControllerField.text.length != 0 && int.parse(_moneyControllerField.text) > 1000){
                          if(int.parse(_moneyControllerField.text)<=lessMoney){
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            int donator_id = prefs.getInt('donator_id');
                            if(donator_id==null){donator_id = -1;}  //nếu chưa đăng nhập
                            String url = baseUrl+"/paypal/donatorid/${donator_id}/projectid/${project.prj_id}/donate";
                            final body = jsonEncode(<String, String>{
                              "price": _moneyControllerField.text,
                              "description":_messageControllerField.text
                            });
                            var res = await http.post(url,headers:header,body: body);
                            Navigator.pop(context);
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context)=>DonateScreen(paypalurl: res.body.toString(),project: project, money: _moneyControllerField.text,))
                            );
                          }else{message='Dự án này chỉ cần ${lessMoney} VNĐ nữa là đủ!';
                          }}else{
                          message  = 'Hãy ủng hộ ít nhất 1.000 VNĐ!';
                        }
                        if(message.length>0){
                          Fluttertoast.showToast(
                              msg: message,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
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
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Thông tin chi tiết',
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(
          //     Icons.more_vert,
          //   ),
          //   onPressed: () {
          //     // do something
          //   },
          // ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(0))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildPostVideo(),                //Video giới thiệu của bài viết
                    SizedBox(height: 8),
                    buildProjectInfo(widget.project),   //Thông tin vắn tắt
                    buildProjectDetails(widget.project),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 45,
        width: 400,
        decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.green[600]),
            borderRadius: BorderRadius.circular(8), color: Colors.green[600]),
        child:((widget.project.status=='activating')?
          FlatButton(
            onPressed:()=> {
            _showDonateDialog(context,widget.project)
          },
            child: Text(
              "Quyên góp ngay",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
            :
        FlatButton(
          onPressed:()=> {
            Navigator.of(context).pop()
          },
          child: Text(
            "Quay lại",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        )
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
            buildNavBarItem(),
          ],
        ),
      ),
    );
  }

  Widget buildNavBarItem() {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 30,
      ),
    );
  }

  Container buildPostVideo() {
    return Container(
      height: MediaQuery.of(context).size.width - 180,
      child: _chewieController != null &&_chewieController.videoPlayerController.value.initialized ? Chewie( controller: _chewieController,) :
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Đang tải'),
        ],
      ),
    );
  }

  Container buildProjectInfo(Project project){
    return Container(
      margin: EdgeInsets.fromLTRB(8,5,8,5),
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
            project.project_name,
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
            project.brief_description,
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

  Container buildDonatorInfo(){
    return Container(
      margin: EdgeInsets.fromLTRB(8,5,8,5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nhà hảo tâm",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "xxxxxxxx231",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54),
          ),
          SizedBox(height:5),
          Container(
            height: 1,
            color: Colors.grey[300],
            margin: EdgeInsets.symmetric(horizontal: 0),
          ),
        ],
      ),
    );
  }

  Container buildProjectDetails(Project project){
    return Container(
      margin: EdgeInsets.fromLTRB(8,5,8,5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProgressPercentRow(project),
          SizedBox(height: 10),
          buildInfoDetailsRow(project),
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
            project.description,
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
          SizedBox(height: 5),
          Container(
              child: Column(children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  items: widget.project.imgList.map((item) => Container(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(item, fit: BoxFit.cover, width: 1000.0),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  )).toList(),
                ),
              ],)
          ),
        ],
      ),
    );
  }

  //Mới chỉ là giao diện - sẽ phát triển chức năng này sau

  // Container buildDonatorsList(){
  //   return Container(
  //     margin: EdgeInsets.fromLTRB(8,5,8,45),
  //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(5),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Danh sách các nhà hảo tâm",
  //           style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black),
  //         ),
  //         Container(
  //             child: Column(children: <Widget>[
  //               buildDonatorInfo(),
  //               buildDonatorInfo(),
  //               buildDonatorInfo(),
  //               buildDonatorInfo(),
  //             ],)
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Row buildInfoDetailsRow(Project project) {
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
                  project.num_of_donations.toString(),
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
                  (project.cur_money/project.target_money*100).round().toString()+" %",
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
            if (project.status == 'activating')
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
                  project.remaining_term.toString()+" Ngày",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  ),
               ],
              ),
            if (project.status == 'reached')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Đã đạt mục tiêu",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green[600],
                    ),
                  ),
                ],
              ),
            if (project.status == 'overdue')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Đã hết thời hạn",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              )
          ],
        ),
      ],
    );
  }

  Row buildProgressPercentRow(Project project) {
    double percent;
    if(project.cur_money >= project.target_money){
      percent = 1.0;
    }
    else{
      percent = project.cur_money / project.target_money;
    }
    MoneyFormatterOutput fo1 = new FlutterMoneyFormatter(
        amount: double.tryParse(project.cur_money.toString()),
        settings: MoneyFormatterSettings(
          thousandSeparator: '.',
          decimalSeparator: ',',
        )
    ).output;
    MoneyFormatterOutput fo2 = new FlutterMoneyFormatter(
        amount: double.tryParse(project.target_money.toString()),
        settings: MoneyFormatterSettings(
          thousandSeparator: '.',
          decimalSeparator: ',',
        )
    ).output;
    return Row(
        children: [
          if (project.status != 'overdue')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đã quyên góp được ${fo1.withoutFractionDigits} đ / ${fo2.withoutFractionDigits} đ",
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
                  percent: percent,
                  progressColor: Colors.green[600],
                ),
              ],
            ),
          if (project.status == 'overdue')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đã quyên góp được "+project.cur_money.toString()+" đ / "+project.target_money.toString()+" đ",
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
                  percent: percent,
                  progressColor: Colors.grey,
                ),
              ],
            )
        ]);
  }
}