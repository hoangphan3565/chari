
import 'dart:io';

import 'package:charity_donator_app/API.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class  DonateScreen extends StatefulWidget{
  DonateScreen(this.paypalurl);
  final paypalurl;
  @override
  _DonateScreenState createState()=> _DonateScreenState();
}
class _DonateScreenState extends State<DonateScreen>{
  // String _loadHTML(){
  //   return '''
  //      <html>
  //       <body onload="document.f.submit();">
  //         <form id="f" name="f" method="post" action="$baseUrl/paypal/donatorid/${widget.donatorid}/projectid/${widget.projectid}/donate";">
  //           <input type="hidden" name="price" value="${widget.money}" />
  //           <input type="hidden" name="description" value="${widget.description}" />
  //         </form>
  //       </body>
  //     </html>
  //   ''';
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 35),
        padding: EdgeInsets.symmetric(horizontal: 5),
        child:
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.paypalurl.toString(),
        ),
      ),
    );
  }
}