import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestore{
  FirebaseFirestore db = FirebaseFirestore.instance;
  static User? user;
  int credits = 10;

  Firestore(){
    user = FirebaseAuth.instance.currentUser ;
  }
}