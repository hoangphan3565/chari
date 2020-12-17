import 'dart:convert';

import 'package:charity_donator_app/API.dart';
import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/models/models.dart';
import 'package:charity_donator_app/screens/screens.dart';
import 'package:charity_donator_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  final List<DonateDetails> donate_details_list;
  final List<Project> projects;
  HistoryScreen({Key key, @required this.donate_details_list,this.projects}) : super(key: key);
  @override
  _HistoryScreenState createState()=> _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>{

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
          'Lịch sử quyên góp',
          style: const TextStyle(
            color: kPrimaryLightColor,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.7,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(0))),
              child: widget.donate_details_list.length == 0 ?
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 8,),
                      Text("Bạn chưa có lịch sử ủng hộ nào!"),
                      SizedBox(height: 8,),
                      Container(
                        height: 0,
                        margin: EdgeInsets.symmetric(horizontal: 0),
                      ),
                    ],
                  )
                )
                    :
                Container(
                  child:  CustomScrollView(
                    slivers: [
                      SliverList(delegate: SliverChildBuilderDelegate((context, index)
                      {return buildProjectInfo(widget.donate_details_list[index]);},
                        childCount: widget.donate_details_list.length,
                      ),
                      )
                    ],
                  ),
                )
            ),
          )
        ],
      ),
    );
  }

  Container buildProjectInfo(DonateDetails donate_details){
    MoneyFormatterOutput fo = new FlutterMoneyFormatter(
        amount: double.tryParse(donate_details.money.toString()),
        settings: MoneyFormatterSettings(
          thousandSeparator: '.',
          decimalSeparator: ',',
        )
    ).output;
    return Container(
      margin: EdgeInsets.fromLTRB(8,5,8,5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Ủng hộ: "+ fo.withoutFractionDigits+' đ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Vào lúc: "+ DateFormat('kk:mm - dd-MM-yyyy').format( DateTime.parse(donate_details.donate_date)),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  donate_details.project_name,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: ()=>{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProjectDetailsScreen(project: widget.projects.where((p) => p.prj_id==donate_details.project_id).elementAt(0),)),
              ),
            },
            child: Container(
              height: 90,
              width: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
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
                    image: NetworkImage(widget.projects.where((p) => p.prj_id==donate_details.project_id).elementAt(0).image_url),
                  )),
            ),
          ),
        ],
      ),
    );
  }


}
