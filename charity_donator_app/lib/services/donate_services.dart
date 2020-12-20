import 'dart:convert';

import 'package:charity_donator_app/API.dart';
import 'package:charity_donator_app/models/models.dart';
import 'package:charity_donator_app/screens/screens.dart';
import 'package:charity_donator_app/utility/utility.dart';
import 'package:charity_donator_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DonateService{
  static showDonateDialog(BuildContext context,Project project) {
    TextEditingController _moneyControllerField = TextEditingController();
    TextEditingController _messageControllerField = TextEditingController();
    String donate_money="";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 2.1,
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
                        donate_money=value;
                      },
                      decoration: InputDecoration(
                        labelText: "Số tiền*: ${MoneyUtility.numberToString(donate_money)}",
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
}