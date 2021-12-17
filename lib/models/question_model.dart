/*
{
"_id": "5df7419150992d49c44291a2",
"question": "La tercera pregunta",
"user": "5dbdb067582e2f395c9d2bd8",
"__v": 0
}
*/

import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  String id;
  String question;
  String user;

  Question({
    required this.id,
    required this.question,
    required this.user,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["_id"],
    question: json["question"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "user": user,
  };
}