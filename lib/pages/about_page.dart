import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     drawer: MyDrawer(),
     appBar: AppBar(
       title: Material(
         child: Column(
           children: [
             Text("About Us",
               style: TextStyle(
                   fontFamily: GoogleFonts.poppins().fontFamily,
                   fontSize: 22,
                 fontWeight: FontWeight.bold
               )
             )
           ],
         ),
       ),
     ),
     body: Material(
       child: Column(
         children: [
           Text("We are central India's one of biggest Importer and Wholesale Supplier of Dry Fruits.",style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily)
           ).text.make().p16(),
         Container(
           child: Column(
              children: [
               Text("In development stage. Developed and Maintain by Mayank Rajput"),
               10.heightBox,
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   ElevatedButton(
                       onPressed: () async{
                         await launchUrl(Uri.parse("https://www.linkedin.com/in/mayank-rajput-638044227/"),mode: LaunchMode.inAppWebView);
                       },
                       child: Text("LinkedIn")
                   ),
                   10.widthBox,
                   ElevatedButton(
                       onPressed: () async{
                         await launchUrl(Uri.parse("https://www.instagram.com/mayankr253/"),mode: LaunchMode.inAppWebView);
                       },
                       child: Text("Instagram")),
                   10.widthBox,
                   ElevatedButton(
                       onPressed: () async{
                         await launchUrl(Uri.parse("https://github.com/mayank0rajput"),mode: LaunchMode.inAppWebView);
                       },
                       child: Text("GitHub"))
                 ],
               )
              ]
           ).p8(),
           decoration: BoxDecoration(
             color: Colors.white,
             border: Border.all(color: MyTheme.borderGrey)
           ),
         ).p16()
         ],
       ),
     ),
   );
  }
}