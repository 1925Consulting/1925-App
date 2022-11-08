import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global.dart';

class SaveDataLocal {
  static SharedPreferences prefs;
  static List data = [];
  static String userId = 'UserId';

  static saveUserData(String userDataId) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(userId, userDataId);
  }

  static Future getUserDataFromLocal() async {
    prefs = await SharedPreferences.getInstance();
    String userString = prefs.getString(userId);
    if (userString != null) {
      return userString;
    } else {
      return null;
    }
  }

  static Future clearDataFromLocal() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.remove(userId);
    user = null;
  }
}
