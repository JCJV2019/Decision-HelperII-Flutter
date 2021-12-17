
import 'dart:convert';

import 'package:decision_helper2/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager{

  Future<String?> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString("login");
  }

  Future<void> setToken(Login login) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("login", jsonEncode(login));
  }

  Future<void> clearData() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}