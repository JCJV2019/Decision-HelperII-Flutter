/*
{
"_id": "5e4d88d54bc3280004b0a812",
"desc": "Marca",
"point": "2",
"question": "5e4d88ca4bc3280004b0a810",
"user": "5dbdb067582e2f395c9d2bd8",
"__v": 0
}
*/

import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  String id;
  String desc;
  String point;
  String question;
  String user;

  Item({
    required this.id,
    required this.desc,
    required this.point,
    required this.question,
    required this.user,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["_id"],
    desc: json["desc"],
    point: json["point"],
    question: json["question"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "desc": desc,
    "point": point,
    "question": question,
    "user": user,
  };
}