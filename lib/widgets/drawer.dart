import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final imageUrl = "https://media.licdn.com/dms/image/D4D03AQGsEbXxXxVNNQ/profile-displayphoto-shrink_400_400/0/1696321647132?e=1718841600&v=beta&t=DkCtD6T6xDWW6erd29eHbZq7X0R8iRgLPH8OsV-Rva8";
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent
                ),
                margin: EdgeInsets.zero,
                accountName: Text("Mayank"),
                accountEmail: Text("abc@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Profile"),
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text("Mail"),
          )
        ],
      ),
    );
  }
}