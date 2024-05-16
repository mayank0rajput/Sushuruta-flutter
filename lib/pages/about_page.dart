import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:google_fonts/google_fonts.dart';
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
                   color: MyTheme.darkBluishColor,
                   fontSize: 22,
                 fontWeight: FontWeight.bold
               )
             )
           ],
         ),
       ),
     ),
     body: Text("We are central India's one of biggest Importer and Wholesale Supplier of Dry Fruits.",style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily)
     ).text.make().p16(),
   );
  }
}