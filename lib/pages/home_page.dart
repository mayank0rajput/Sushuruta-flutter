import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/pages/home_widgets/catalog_header.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/utils/store.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'home_widgets/catalog_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();

    if(FirebaseAuth.instance.currentUser == null){
      Navigator.of(context).pushReplacementNamed(MyRoutes.loginRoute);
    }

  }
  void loadData() async{
     await Future.delayed(Duration(seconds: 2));
     var catalog = await rootBundle.loadString("assets/files/catalog.json");
     var decodedData = jsonDecode(catalog);
     var productData = decodedData["products"];
     CatalogueModel.items = List.from(productData)
         .map<Product>((item) => Product.fromMap(item))
         .toList();
     setState(() { });
  }
  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
        backgroundColor: context.canvasColor,
        floatingActionButton: VxBuilder(
            mutations: {AddMutation, RemoveMutation},
            builder: (context, store, status) {
              return FloatingActionButton(
                onPressed: () =>
                    Navigator.pushNamed(context, MyRoutes.cartPageRoute),
                backgroundColor: MyTheme.primaryGreen,
                child: Icon(Icons.shopping_cart, color: Colors.white).badge(
                    size: 13,
                    color: Colors.redAccent,
                    count: _cart.items.length),
              );
            }),
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          foregroundColor: MyTheme.black,
          title: Material(
              color: context.cardColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Sushuruta".text.xl5.bold.make(),
                ],
              )),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [75.widthBox, CatalogHeader()]),
                if (CatalogueModel.items != null &&
                    CatalogueModel.items.isNotEmpty)
                  CatalogList().pLTRB(0, 15, 0, 16).expand()
                else
                  CircularProgressIndicator().centered().expand(),
              ],
            ),
          ),
        ));
  }
}
