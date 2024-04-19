import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/routes.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool changeButton = false;
  String name = "";
  Widget build(BuildContext context){
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            "assets/images/login_image.png",
            fit: BoxFit.cover
          ),
          SizedBox(height: 10.0),
          Text("Welcome $name",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 32),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Username",
                    labelText: "Username",
                    hintStyle: TextStyle(color: Colors.black26),
                  ),
                  onChanged: (value){
                    name = value;
                    setState(() {

                    });
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    labelText: "Password",
                    hintStyle: TextStyle(color: Colors.black26),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              setState(() {
                changeButton = true;
              });
              await Future.delayed(Duration(seconds: 1));
              Navigator.pushNamed(context, MyRoutes.homeRoute);
            },
            child: AnimatedContainer(
                duration: Duration(seconds: 1),
                width: (changeButton ? 50 : 150),
                height: 50,
                alignment: Alignment.center,
                child: changeButton? Icon(
                  Icons.done,
                  color: Colors.white,
                ) : Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius:
                    BorderRadius.circular(changeButton ? 50 : 8)
                ),
              )
          )
        ],
      ),
    );
  }
}