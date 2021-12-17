
import 'dart:convert';

import 'package:decision_helper2/models/login_model.dart';
import 'package:decision_helper2/models/question_model.dart';
import 'package:decision_helper2/repositories/environment.dart';
import 'package:decision_helper2/services/shared_prefs_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class QuestionRepo {

  Future<List<Question>> getQuestions() async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/pregunta/usuario/${login.idUser}");

    Response response = await http.get(uri,headers: headers);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      //print("GETS RESPONSE: ${response.body}");
      List<Map<String, dynamic>> decodedResponse =  List.from(jsonDecode(response.body));
      List<Question> questions = decodedResponse.map((element) => Question.fromJson(element)).toList();

      return questions;
    } else
      throw Exception("Error requesting questions");

  }

  Future<Question> getQuestion(String idQuestion) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/pregunta/$idQuestion}");

    Response response = await http.get(uri,headers: headers);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      //print("GET RESPONSE: ${response.body}");
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      Question question = Question.fromJson(decodedResponse);

      return question;
    } else
      throw Exception("Error requesting question");

  }

  Future<Question> addQuestion(Question objQuestion) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/pregunta");
    var objBody = {
      "question": objQuestion.question,
      "user": objQuestion.user
    };
    Response response = await http.post(uri,headers: headers,body: objBody);
    if(response.statusCode >= 200 && response.statusCode <= 300) {
      //print("ADD RESPONSE: ${response.body}");
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      Question question = Question.fromJson(decodedResponse);
      // Retorna el registro grabado o nuevo

      return question;
    } else
      throw Exception("Error adding question");

  }

  Future<Question> editQuestion(Question objQuestion) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/pregunta/${objQuestion.id}");
    var objBody = {
      "_id": objQuestion.id,
      "question": objQuestion.question,
      "user": objQuestion.user
    };

    Response response = await http.put(uri,headers: headers, body: objBody);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      //print("EDIT RESPONSE: ${response.body}");
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      Question question = Question.fromJson(decodedResponse);
      // Retorna el registro de antes de la edición/grabación

      return question;
    } else
      throw Exception("Error editing question");

  }

  Future<Question> deleteQuestion(String idQuestion) async {

    String stringLogin = await SharedPreferencesManager().getToken() ?? "";
    Login login = loginFromJson(stringLogin);
    var headers = {
      "authorization":"Bearer ${login.token}",
    };

    Uri uri = Uri.parse("$kApiUrl/pregunta/$idQuestion");

    Response response = await http.delete(uri,headers: headers);

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      //print("DELETE RESPONSE: ${response.body}");
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      Question question = Question.fromJson(decodedResponse);
      // Retorna el registro de antes de la edición/grabación

      return question;
    } else
      throw Exception("Error deleting question");

  }

}
