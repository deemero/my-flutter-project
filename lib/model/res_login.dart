// To parse this JSON data, do
//
//     final resLogin = resLoginFromJson(jsonString);

import 'dart:convert';

ResLogin resLoginFromJson(String str) => ResLogin.fromJson(json.decode(str));

String resLoginToJson(ResLogin data) => json.encode(data.toJson());

class ResLogin {
  ResLogin({
    this.value,
    this.message,
    this.username,
    this.fullname,
    this.id,
  });

  int? value;
  String? message;
  String? username;
  String? fullname;
  String? id;

  factory ResLogin.fromJson(Map<String, dynamic> json) => ResLogin(
        value: json["value"] == null ? null : json["value"],
        message: json["message"] == null ? null : json["message"],
        username: json["username"] == null ? null : json["username"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "value": value == null ? null : value,
        "message": message == null ? null : message,
        "username": username == null ? null : username,
        "fullname": fullname == null ? null : fullname,
        "id": id == null ? null : id,
      };
}
