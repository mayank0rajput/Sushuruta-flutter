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
                  color: MyTheme.primaryGrey
                ),
                margin: EdgeInsets.zero,
                accountName: Text("Guest User"),
                accountEmail: Text("abc@gmail.com"),
              ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: (ModalRoute.of(context)?.settings.name=="/home")
                  ?MyTheme.primaryGreen:Drawer().surfaceTintColor
            ),
            title: Text("Home",
              style: TextStyle(
                  color: (
                      (ModalRoute.of(context)?.settings.name=="/home")
                          ?MyTheme.primaryGreen:Drawer().surfaceTintColor
                  )
              )
            ),
            onTap: (){
              Navigator.pushNamed(context, MyRoutes.homeRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.chat,
              color: (ModalRoute.of(context)?.settings.name=="/chat")
              ?MyTheme.primaryGreen:Drawer().surfaceTintColor,
            ),
            title: Text("Chat",
                style: TextStyle(
                    color: (
                        (ModalRoute.of(context)?.settings.name=="/chat")
                            ?MyTheme.primaryGreen:Drawer().surfaceTintColor
                    )
                )
            ),
            onTap: (){
              Navigator.pushNamed(context, MyRoutes.chatPageRoute);
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
            leading: Icon(Icons.info_outline,
              color: (ModalRoute.of(context)?.settings.name=="/about")
                  ?MyTheme.primaryGreen:Drawer().surfaceTintColor,
            ),
            title: Text("About",
            style: TextStyle(
              color: (ModalRoute.of(context)?.settings.name=="/about")
                  ?MyTheme.primaryGreen:Drawer().surfaceTintColor
            ),),
            onTap: (){
              Navigator.pushNamed(context, MyRoutes.aboutPageRoute);
            },
          )
        ],
      ),
    );
  }

}