import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/Firestore.dart';
import 'package:flutter_application_1/utils/SharedPrefs.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/themes.dart';

class MyDrawer extends StatelessWidget {

  Future<String?> getName ()async{
    return await Profile.getName();
  }
  Future<String?> getEmail ()async{
    return await Profile.getName();
  }

  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: MyTheme.primaryGreen
                ),
                margin: EdgeInsets.zero,
                accountName: FutureBuilder<String?>(
                  future: getName(),
                  builder: (context,snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading..."); // Placeholder during loading
                    }else if (snapshot.hasData) {
                      return Text(snapshot.data ?? "Guest User"); // Show the fetched name
                    } else {
                      return Text("Guest User"); // Fallback
                    }
                  },
                ),
                accountEmail: FutureBuilder<String?>(
                  future: getEmail(),
                  builder: (context,snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading..."); // Placeholder during loading
                    }else if (snapshot.hasData) {
                      return Text(snapshot.data ?? "No E-Mail Address"); // Show the fetched name
                    } else {
                      return const Text("No E-Mail Address"); // Fallback
                    }
                  },
                ),
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