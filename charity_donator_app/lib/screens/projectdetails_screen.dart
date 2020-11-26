import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:charity_donator_app/models/project_model.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:video_player/video_player.dart';



class ProjectDetailsScreen extends StatefulWidget {
  final Project project;
  ProjectDetailsScreen({@required this.project});
  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  List<String> listProjectIdFavorite = new List<String>();

  @override
  void initState() {
    super.initState();
    this.initializePlayer(widget.project.video_url);
  }


  Future<void> initializePlayer(String video_url) async {
    _videoPlayerController = VideoPlayerController.network(video_url);
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    setState(() {});
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
                  BorderRadius.vertical(top: Radius.circular(0))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildPostVideo(),                //Video giới thiệu của bài viết
                    SizedBox(height: 8),
                    buildProjectInfo(widget.project),   //Thông tin vắn tắt
                    buildProjectDetails(widget.project),
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
        child:FlatButton(
          onPressed:()=> {print(widget.project.imgList)},
          child: Text(
            "Quyên góp ngay",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
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
        height: 30,
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


  Container buildPostVideo() {
    return Container(
      height: MediaQuery.of(context).size.width - 200,
      child: _chewieController != null &&_chewieController.videoPlayerController.value.initialized ? Chewie( controller: _chewieController,) : Column(
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

  Container buildProjectDetails(Project project){
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
          buildProgressPercentRow(project.cur_money,project.target_money),
          SizedBox(height: 10),
          buildInfoDetailsRow(project.num_of_donations,project.remaining_term,project.cur_money,project.target_money),
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