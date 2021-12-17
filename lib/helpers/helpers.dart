
import 'package:decision_helper2/models/question_model.dart';
import 'package:decision_helper2/repositories/item_repository.dart';
import 'package:decision_helper2/repositories/question_repository.dart';
import 'package:flutter/material.dart';

class Helpers {

  static ScaffoldMessage(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
        )));
  }

  static InputDecoration buildInputDecoration({
    String? hintText, String? errorText,Icon? icon}) {
    return InputDecoration(
        hintText: hintText != null ? hintText : "",
        fillColor:Colors.white,
        filled:true,

        border:OutlineInputBorder(
            borderSide: BorderSide(color:Colors.black54)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.black54)
        ),

        errorStyle: TextStyle(fontSize: 14,color:Colors.red),

        prefixIcon: icon != null ? icon : Icon(Icons.person_outline)
    );
  }

  static bool isEmail(String text){

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);

    return emailValid;

  }

  static Future<Map<String, dynamic>> deleteQuestionAll(String idQuestion) async {
    var nPositives = await ItemRepo().deletePositivos(idQuestion);
    var nNegatives = await ItemRepo().deleteNegativos(idQuestion);
    Question question = await QuestionRepo().deleteQuestion(idQuestion);
    Map<String, dynamic> result = {
      "nPositives": nPositives,
      "nNegatives": nNegatives,
      "question": question
    };
    return result;
  }

}