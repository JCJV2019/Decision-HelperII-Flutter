
import 'dart:convert';

import 'package:decision_helper2/models/login_model.dart';
import 'package:decision_helper2/repositories/environment.dart';
import 'package:decision_helper2/services/shared_prefs_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthRepo{

  Future<Login> signIn(String email, String password) async {
    var body = {
      "email":email,
      "password":password
    };

    Uri uri = Uri.parse("$kApiUrl/users/login");

    Response response = await http.post(uri,body: body);

    if(response.statusCode >= 200 && response.statusCode < 300) {
      var decodedResponse = jsonDecode(response.body);
      Login login = Login.fromJson(decodedResponse);

      print("TOKEN: ${login.token}");

      await SharedPreferencesManager().setToken(login);

      return login;

    } else {

      throw Exception("Error requesting resources.");

    }

  }

  Future<Login> signUp(String user, String email, String password) async {
    var body = {
      "name": user,
      "email":email,
      "password":password
    };

    Uri uri = Uri.parse("$kApiUrl/users/register");

    Response response = await http.post(uri,body: body);

    if(response.statusCode >= 200 && response.statusCode < 300) {
      var decodedResponse = jsonDecode(response.body);
      Login login = Login.fromJson(decodedResponse);

      print("MESSAGE: ${login.message}");

      return login;

    }else{

      throw Exception("Error requesting resources.");

    }

  }

}