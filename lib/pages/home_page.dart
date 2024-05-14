import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/pages/home_widgets/catalog_header.dart';
import 'package:flutter_application_1/pages/home_widgets/catalog_image.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/item_widget.dart';
import 'home_widgets/catalog_list.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 30;

  final String name = "Codepur";

  @override
  void initState(){
    super.initState();
    loadData();
  }
  void loadData() async{
     await Future.delayed(Duration(seconds: 2));
     var catalog = await rootBundle.loadString("assets/files/catalog.json");
     var decodedData = jsonDecode(catalog);
     var productData = decodedData["products"];
     CatalogueModel.items = List.from(productData)
         .map<Item>((item) => Item.fromMap(item))
         .toList();
     setState(() { });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, MyRoutes.cartPageRoute),
        backgroundColor: MyTheme.darkBluishColor,
        child: Icon(Icons.shopping_cart,color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if (CatalogueModel.items != null && CatalogueModel.items.isNotEmpty)
                CatalogList().py16().expand()
              else
                CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      )
    );
  }
}