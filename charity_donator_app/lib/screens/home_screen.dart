import 'dart:async';
import 'dart:convert';
import 'dart:convert' show utf8;

import 'package:charity_donator_app/API.dart';
import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/models/models.dart';
import 'package:charity_donator_app/screens/screens.dart';
import 'package:charity_donator_app/utility/utility.dart';
import 'package:charity_donator_app/widgets/custom_alert_dialog.dart';
import 'package:charity_donator_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  final List<Project> projects;
  final List<ProjectType> project_types;
  HomeScreen({Key key, @required this.projects,this.project_types}) : super(key: key);

  @override
  _HomeScreenState createState()=> _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>{

  TextEditingController _moneyControllerField = TextEditingController();
  TextEditingController _messageControllerField = TextEditingController();
  String donate_money="";

  int _selectedProjectType  = 0;
  var listProjectIdFavorite = new List<String>();



  @override
  initState() {
    super.initState();
    _getlistProjectIdFavorite();
    _selectedProjectType  = 0;
  }

  @override
  dispose() {
    super.dispose();
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
            'Trang chủ',
            style: const TextStyle(
              color: kPrimaryLightColor,
              fontSize: 27.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.2,
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              floating: true,
              title: widget.project_types.length == 0 ? Text(""):
              Text(
                widget.project_types.where((i) => i.id==_selectedProjectType).elementAt(0).name.toString(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              actions: <Widget>[
                widget.project_types.length == 0 ? Text(""):
                PopupMenuButton<ProjectType>(
                  icon:  Icon(Icons.menu_open_outlined,),
                  onSelected: (ProjectType result) { setState(() {
                    _selectedProjectType = result.id;
                    print(_selectedProjectType);
                  }); },
                  itemBuilder: (BuildContext context) {
                    return widget.project_types.map((ProjectType choice) {
                      return PopupMenuItem(
                        value: choice,
                        child: Text(choice.name),
                      );
                    }).toList();
                  },
                )
              ],
            ),
            _selectedProjectType == 0 ?
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return buildPostSection(widget.projects[index]);
                },
                childCount: widget.projects.length,
              ),
            )
                :
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return buildPostSection(widget.projects.where((i) => i.prt_id==_selectedProjectType).elementAt(index));
                },
                childCount: widget.projects.where((i) => i.prt_id==_selectedProjectType).length,
              ),
            )
          ],
        )
    );
  }

  //Function and dialog
  _getlistProjectIdFavorite() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String temp = _prefs.getString('donator_favorite_project');
    if(temp!=null){
      setState(() {
        listProjectIdFavorite = temp.split(" ");
      });
    }
  }

  _changeStateFavorite(int projectid,bool curstate)async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String username = _prefs.get("username");
    int donatorid = _prefs.get("donator_id");
    if(username == null){
      _showDialogAskForLoginOrRegister(context);
      return;
    }
    if(curstate){
      API.postRemoveProjectFromFavorite(projectid, donatorid).then((response) {
        setState(() {
          _prefs.setString('donator_favorite_project',json.decode(response.body)['favoriteProject']);
          print('hủy thả tim! danh sách hiện tại: '+_prefs.getString('donator_favorite_project').toString());
        });
      });
      listProjectIdFavorite.remove(projectid.toString());
    }else{
      API.postAddProjectToFavorite(projectid, donatorid).then((response) {
        setState(() {
          _prefs.setString('donator_favorite_project',json.decode(response.body)['favoriteProject']);
          print('thả tim! danh sách hiện tại: '+_prefs.getString('donator_favorite_project').toString());
        });
      });
      listProjectIdFavorite.add(projectid.toString());
    }
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
                        labelText: "Số tiền: ${MoneyUtility.numberToString(this.donate_money)}",
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
                        fontWeight: FontWeight.bold,
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
                            builder: (context)=>DonateScreen(paypalurl: res.body.toString(),project: project, money: _moneyControllerField.text,)
                        )
                        );
                      },
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }

  _showDialogAskForLoginOrRegister(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height /3.3,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text("Để thực hiện chức năng này bạn hãy đăng nhập trước",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    RoundedButton(
                        text: "Đăng nhập",
                        press: (){
                          Navigator.pop(context);
                          Navigator.push(context,MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
                        }
                    ),
                    Container(
                      height: 1.5,
                      color: Colors.grey[300],
                      margin: EdgeInsets.symmetric(horizontal: 0),
                    ),
                    SizedBox(height: 10),
                    Text("Nếu chưa có tài khoản đăng ký ngay tại đây"),
                    RoundedButton(
                        text: "Đăng ký",
                        press: (){
                          Navigator.pop(context);
                          Navigator.push(context,MaterialPageRoute(builder: (BuildContext ctx) => SignUpScreen()));
                        }
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  //Build component
  Container buildPostSection(Project project) {
    return Container(
      margin: EdgeInsets.fromLTRB(8,4,8,4),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPostPicture(project),
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
          buildProgressPercentRow(project),
          SizedBox(
            height: 5,
          ),
          buildInfoDetailsRow(context,project),
        ],
      ),
    );
  }

  Stack buildPostPicture(Project project) {
    return Stack(
      children: [
        InkWell(
          onTap: ()=>{
            Navigator.push(
            context,
               MaterialPageRoute(builder: (context) => ProjectDetailsScreen(project: project,)),
            ),
          },
          child: Container(
            height: MediaQuery.of(context).size.width - 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
                  image: NetworkImage(project.image_url),
                )),
          ),
        ),

        Positioned(
          bottom: 20,
          right: 20,
          child: InkWell(
            onTap: ()=> {
              _changeStateFavorite(project.prj_id,listProjectIdFavorite.contains(project.prj_id.toString())),
            },
            child: listProjectIdFavorite.contains(project.prj_id.toString()) == true ?
            Icon(Icons.favorite, size: 35, color: Colors.green.withOpacity(0.9))
                :
            Icon(Icons.favorite, size: 35, color: Colors.white.withOpacity(0.9)),
          ),
        )

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
                  progressColor: Colors.grey,
                ),
              ],
            )
        ]);
  }

  Row buildInfoDetailsRow(BuildContext context, Project project) {
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
                  project.num_of_donations.toString(),
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
            if(project.status == 'activating')
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
            if(project.status != 'activating')
              Column(),
          ],
        ),
        if(project.status == 'activating')
          Container(
            width: 125,
            height: 35,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.green[600]),
                borderRadius: BorderRadius.circular(10), color: kPrimaryLightColor),
            child:FlatButton(
              onPressed:() => {
                _showDonateDialog(context,project),
              },
              child: Text(
                "Quyên góp",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.green[600]),
              ),
            ),
          ),
        if(project.status == 'reached')
          Container(
            width: 180,
            height: 35,
            decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: Colors.grey),
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child:FlatButton(
              onPressed:() => {},
              child: Text(
                "Đã đạt mục tiêu",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
            ),
          ),
        if(project.status == 'overdue')
          Container(
            width: 125,
            height: 35,
            decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: Colors.grey),
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child:FlatButton(
              onPressed:() => {},
              child: Text(
                "Đã hết hạn",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }

}
