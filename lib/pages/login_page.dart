import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/SharedPrefs.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool changeButton = false;
  String name = "";
  void moveToHome(BuildContext context) async{
    // UserCredential userCredential;
    // if (!Platform.isAndroid &&
    //     !Platform.isIOS) {
    //   FirebaseAuth.instance.signInWithRedirect(GoogleAuthProvider());
    //   userCredential = await
    // }else{
    //   GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //   GoogleSignInAuthentication? gooleAuth = await googleUser?.authentication;
    //   AuthCredential credential = GoogleAuthProvider.credential(
    //       accessToken: gooleAuth?.accessToken,
    //       idToken: gooleAuth?.idToken
    //   );
    //   userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    // }

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the Google user
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final userCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Sign in to Firebase with the credential
    await FirebaseAuth.instance.signInWithCredential(userCredential);

    User? user = FirebaseAuth.instance.currentUser;

    if(user != null){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Logging in as ${user.displayName}."),
            duration: Duration(seconds: 5),
          )
      );
      await Profile.saveUser(user.uid);
      await Profile.saveGuest(false);
      await Profile.saveName(user.displayName!);
      await Profile.saveEmail(user.email!);
      Profile.refreshCreditNewDay();
      Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
    }
  }

  void signInAsGuest(BuildContext context) async{
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    User? user = userCredential.user;
    if(user != null){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Logging in as guest."),
            duration: Duration(seconds: 5),
          )
      );
      await Profile.saveUser(user.uid);
      await Profile.saveGuest(true);
      Profile.refreshCreditNewDay();
      Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
    }
  }

  Widget build(BuildContext context){
    return Material(
      color: Colors.white,
      child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                Image.asset(
                  "assets/images/login_image.png",
                  fit: BoxFit.contain,
                  height: (MediaQuery.of(context).size.height * 0.4),
                ),
                const Text("Glad to see you!" ,
                    style:TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                )),
                SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                Material(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(changeButton ? 50 : 8),
                  child: InkWell(
                    onTap: () => moveToHome(context),
                    child: AnimatedContainer(
                        duration:const  Duration(seconds: 1),
                        width: (changeButton ? 50 : 180),
                        height: 40,
                        alignment: Alignment.center,
                        child: changeButton? const Icon(
                          Icons.done,
                          color: Colors.white,
                        ) : Text(
                          "Login with Google ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                            fontSize: 19,
                          ),
                        ),
                      )
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Text("OR",
                  style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                )
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Material(
                  // color: Colors.deepPurple,
                  // borderRadius: BorderRadius.circular(changeButton ? 50 : 8),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        onTap: () => signInAsGuest(context),
                        child: Text(
                          "Sign in as Guest",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
    );
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the Google user
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Sign in to Firebase with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}