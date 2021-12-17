
import 'dart:convert';

import 'package:decision_helper2/models/item_model.dart';
import 'package:decision_helper2/models/login_model.dart';
import 'package:decision_helper2/repositories/environment.dart';
import 'package:decision_helper2/services/shared_prefs_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ItemRepo {

  Future<List<Item>> getItemsPositivos(String idQuestion) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/positivos/pregunta/${idQuestion}");

    Response response = await http.get(uri,headers: headers);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      //print("GETS ITEMS POS RESPONSE: ${response.body}");
      List<Map<String, dynamic>> decodedResponse =  List.from(jsonDecode(response.body));
      List<Item> itemsPos = decodedResponse.map((element) => Item.fromJson(element)).toList();

      return itemsPos;
    } else
      throw Exception("Error requesting items positives");

  }

  Future<List<Item>> getItemsNegativos(String idQuestion) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/negativos/pregunta/${idQuestion}");

    Response response = await http.get(uri,headers: headers);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      //print("GETS ITEMS NEG RESPONSE: ${response.body}");
      List<Map<String, dynamic>> decodedResponse =  List.from(jsonDecode(response.body));
      List<Item> itemsNeg = decodedResponse.map((element) => Item.fromJson(element)).toList();

      return itemsNeg;
    } else
      throw Exception("Error requesting items positives");

  }

  addPositivo(Item objItem) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/positivos");
    var objBody = {
      "desc": objItem.desc,
      "point": objItem.point,
      "question": objItem.question,
      "user": objItem.user
    };

    Response response = await http.post(uri,headers: headers, body: objBody);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      print("ADD POS RESPONSE: ${response.body}");
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      Item item = Item.fromJson(decodedResponse);
      // Retorna el registro añadido

      return item;
    } else
      throw Exception("Error adding Item Positive");

  }

  addNegativo(Item objItem) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/negativos");
    var objBody = {
      "desc": objItem.desc,
      "point": objItem.point,
      "question": objItem.question,
      "user": objItem.user
    };

    Response response = await http.post(uri,headers: headers, body: objBody);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      //print("ADD NEG RESPONSE: ${response.body}");
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      Item item = Item.fromJson(decodedResponse);
      // Retorna el registro añadido

      return item;
    } else
      throw Exception("Error adding Item Negative");

  }

  editPositivo(Item objItem) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/positivos/${objItem.id}");
    var objBody = {
      "_id": objItem.id,
      "desc": objItem.desc,
      "point": objItem.point,
      "question": objItem.question,
      "user": objItem.user
    };

    Response response = await http.put(uri,headers: headers, body: objBody);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      //print("EDIT POS RESPONSE: ${response.body}");
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      Item item = Item.fromJson(decodedResponse);
      // Retorna el registro borrado

      return item;
    } else
      throw Exception("Error editing Item Positive");

  }

  editNegativo(Item objItem) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/negativos/${objItem.id}");
    var objBody = {
      "_id": objItem.id,
      "desc": objItem.desc,
      "point": objItem.point,
      "question": objItem.question,
      "user": objItem.user
    };

    Response response = await http.put(uri,headers: headers, body: objBody);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      print("EDIT NEG RESPONSE: ${response.body}");
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      Item item = Item.fromJson(decodedResponse);
      // Retorna el registro borrado

      return item;
    } else
      throw Exception("Error editing Item Negative");

  }

  Future<Item> deletePositivo(String idItem) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/positivos/$idItem");

    Response response = await http.delete(uri,headers: headers);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      print("RESPONSE: ${response.body}");
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      Item item = Item.fromJson(decodedResponse);
      // Retorna el registro borrado

      return item;
    } else
      throw Exception("Error deleting Item Positive");

  }

  Future<Item> deleteNegativo(String idItem) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/negativos/$idItem");

    Response response = await http.delete(uri,headers: headers);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      print("RESPONSE: ${response.body}");
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      Item item = Item.fromJson(decodedResponse);
      // Retorna el registro borrado

      return item;
    } else
      throw Exception("Error deleting Item Negative");

  }

  Future<int> deletePositivos(String idQuestion) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/positivos/pregunta/$idQuestion");

    Response response = await http.delete(uri,headers: headers);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      print("RESPONSE: ${response.body}");
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      int deletedCount = decodedResponse['deletedCount'];
      // Retorna la cantidad de registros borrados

      return deletedCount;
    } else
      throw Exception("Error deleting Items Positives");

  }

  Future<int> deleteNegativos(String idQuestion) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/negativos/pregunta/$idQuestion");

    Response response = await http.delete(uri,headers: headers);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      print("RESPONSE: ${response.body}");
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      int deletedCount = decodedResponse['deletedCount'];
      // Retorna la cantidad de registros borrados

      return deletedCount;
    } else
      throw Exception("Error deleting Items Negatives");

  }  

}