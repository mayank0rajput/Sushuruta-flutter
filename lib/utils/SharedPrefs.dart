import 'dart:async';
import 'dart:html';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  static const _keyUserID = 'User_ID';
  static const _keyname = 'User_name';
  static const _keymail = 'User_Email';
  static const _keyCredits = 'User_Credits';
  static const _keyPhone = 'User_Phone';
  static const _keyAddress = 'User_Address';
  static const _isGuest = 'isGuest';
  static const _keyLastRefreshed = 'lastRefreshed';

  static Future<void> saveGuest(bool isguest)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isGuest, isguest);
  }
  static Future<void> saveName (String name)async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyname, name);
  }
  static Future<void> saveEmail (String email)async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keymail,email);
  }
  static Future<void> saveUser (String userId)async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserID, userId);
  }
  static Future<void> saveCredits (int credits)async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCredits, credits);
  }
  static Future<void> savePhone (String phone)async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPhone, phone);
  }
  static Future<void> saveAddress (String address)async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAddress, address);
  }

  static Future<String?> getName () async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyname);
  }
  static Future<String?> getEmail () async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keymail);
  }
  static Future<bool?> getGuest () async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isGuest);
  }
  static Future<int> getCredits () async{
    final prefs = await SharedPreferences.getInstance();
    int? credits = await prefs.getInt(_keyCredits);
    return credits!=null ? credits : -1;
  }
  static Future<String?> getPhone () async{
    final prefs = await SharedPreferences.getInstance();
    String? phone = await prefs.getString(_keyPhone);
    return phone;
  }
  static Future<String?> getAddress () async{
    final prefs = await SharedPreferences.getInstance();
    String? address = await prefs.getString(_keyAddress);
    return address;
  }


  static Future<void> refreshCreditNewDay()async{
    final prefs = await SharedPreferences.getInstance();
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String? lastUpdatedDate = prefs.getString(_keyLastRefreshed);

    if(lastUpdatedDate == null || lastUpdatedDate != currentDate){
      await prefs.setString(_keyLastRefreshed, currentDate); // set date
      // refresh credit
      bool isGuest = await prefs.getBool(_isGuest) ?? true;
      if (isGuest){
        saveCredits(10);
      }else{
        saveCredits(25);
      }
    }
  }
  static Future<void> clearData()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}