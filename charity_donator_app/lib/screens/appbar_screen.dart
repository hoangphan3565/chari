import 'dart:async';
import 'dart:convert';
import 'dart:convert' show utf8;

import 'package:charity_donator_app/API.dart';
import 'package:charity_donator_app/models/models.dart';
import 'package:charity_donator_app/screens/notifications_screen.dart';
import 'package:charity_donator_app/screens/screens.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens.dart';

class AppBarScreen extends StatefulWidget {
  @override
  _AppBarScreenState createState() => _AppBarScreenState();
}

class _AppBarScreenState extends State<AppBarScreen> {

  Timer _getNewDataAfter;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  bool islogin = false;
  var projects = new List<Project>();
  var project_types = new List<ProjectType>();
  var donate_details_list = new List<DonateDetails>();
  var donator = new Donator(null,null,null,null,null,null);

  List<String> listProjectIdFavorite = new List<String>();


  @override
  initState() {
    super.initState();
    _checkLogin();
    _getDatas();
    _getDonateHistory();
    //Gọi API get dữ liệu để Cập nhật những thay đổi của các bài viết sau một khoảng thời gian
    _getNewDataAfter = Timer.periodic(Duration(seconds: 10), (Timer t) {
      setState(() {
        _getDatas();
        _getDonateHistory();
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    _getNewDataAfter.cancel();
  }

  _getDonateHistory() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int donator_id = _prefs.getInt('donator_id');
    if(donator_id!=null){
      API.getDonateDetailsListByDonatorId(donator_id).then((response) {
        setState(() {
          List<dynamic> list = json.decode(utf8.decode(response.bodyBytes));
          donate_details_list = list.map((model) => DonateDetails.fromJson(model)).toList();
        });
      });
      return;
    }
  }

  _getDatas() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String temp = _prefs.getString('donator_favorite_project');
    if(temp!=null){
      listProjectIdFavorite = temp.split(" ");
    }
    API.getProjects().then((response) {
      setState(() {
        List<dynamic> list = json.decode(utf8.decode(response.bodyBytes));
        projects = list.map((model) => Project.fromJson(model)).toList();
      });
      //Lấy dữ liệu hình ảnh của tất cả dự án
      for (int i = 0;i<projects.length;i++) {
        API.getImageByProjectID(projects[i].prj_id).then((response) {
          setState(() {
            List<String> imglist = (json.decode(response.body) as List<dynamic>).cast<String>();
            projects[i].imgList = imglist;
          });
        });
      }
    });
    API.getProjectTypes().then((response) {
      setState(() {
        List<dynamic> list = json.decode(utf8.decode(response.bodyBytes));
        project_types = list.map((model) => ProjectType.fromJson(model)).toList();
        project_types.insert(0, ProjectType(0, '', 'Tất cả bài viết'));
      });
    });
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
        donator.full_name = prefs.getString('donator_full_name').toString();
        donator.id = prefs.getInt('donator_id');
        donator.address = prefs.getString('donator_address').toString();
        donator.phone_number = prefs.getString('donator_phone').toString();
        donator.avatar_url = prefs.getString('donator_avatar_url').toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.home, size: 30,color: Colors.green[600],),
            Icon(Icons.favorite, size: 30,color: Colors.green[600],),
            Icon(Icons.notifications, size: 30,color: Colors.green[600],),
            Icon(Icons.history, size: 30,color: Colors.green[600],),
            Icon(Icons.account_circle, size: 30,color: Colors.green[600],),
          ],
          color: Colors.green[100],
          buttonBackgroundColor: Colors.green[100],
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              if(index == 0 || index == 3){
                _getDatas();
                _getDonateHistory();
              }
              _page = index;
            });
          },
        ),
        body: islogin == false ?
              (_page == 0 ? HomeScreen(projects: this.projects,project_types :this.project_types)
              : AskScreen())
            :
              (_page == 0 ? HomeScreen(projects: this.projects, project_types: this.project_types,)
              : _page == 1 ? FavoriteScreen(projects: this.projects)
              : _page == 2 ? NotificationsScreen()
              : _page == 3 ? HistoryScreen(donate_details_list: this.donate_details_list,projects: this.projects)
              : PersonalScreen(donator: this.donator))
    );
  }


}

