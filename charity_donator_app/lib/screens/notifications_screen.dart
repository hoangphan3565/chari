import 'package:charity_donator_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState()=> _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>{
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
          'Thông báo',
          style: const TextStyle(
            color: kPrimaryLightColor,
            fontSize: 27.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.2,
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
                child: 1==1 ?
                Container(
                    child: Column(
                      children: [
                        SizedBox(height: 8,),
                        Text("Bạn chưa có thông báo nào!"),
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
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
