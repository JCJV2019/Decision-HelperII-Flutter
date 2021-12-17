
/*
{
"message": "Login Ok",
"token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJDSk9SREFOIiwiaWF0IjoxNjM4MDk0OTA5LCJleHAiOjE2MzkzMDQ1MDl9.wAx99QE4bmzRHde7PeNX5D2XSamAwBqZT_Ks8g3V2ZI",
"expires_in": "14 days",
"expires_at": "12-12-2021 10:21:49",
"id_user": "5dbdb067582e2f395c9d2bd8",
"name_user": "CJORDAN"
}
*/

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String message;
  String? token;
  String? expiresIn;
  String? expiresAt;
  String? idUser;
  String? nameUser;

  Login({
    required this.message,
    this.token,
    this.expiresIn,
    this.expiresAt,
    this.idUser,
    this.nameUser,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    message: json["message"],
    token: json["token"] ?? "",
    expiresIn: json["expires_in"] ?? "",
    expiresAt: json["expires_at"] ?? "",
    idUser: json["id_user"] ?? "",
    nameUser: json["name_user"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "expires_in": expiresIn,
    "expires_at": expiresAt,
    "id_user": idUser,
    "name_user": nameUser,
  };
}
