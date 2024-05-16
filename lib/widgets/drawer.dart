import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/themes.dart';

class MyDrawer extends StatelessWidget {
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.indigo
                ),
                margin: EdgeInsets.zero,
                accountName: Text("Guest User"),
                accountEmail: Text("abc@gmail.com"),
              ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: (){
              Navigator.pushNamed(context, MyRoutes.homeRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Cart"),
            onTap: (){
              Navigator.pushNamed(context, MyRoutes.cartPageRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About"),
            onTap: (){
              Navigator.pushNamed(context, MyRoutes.aboutPageRoute);
            },
          )
        ],
      ),
    );
  }
}