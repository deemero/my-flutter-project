// To parse this JSON data, do
//
//     final resGetNews = resGetNewsFromJson(jsonString);

import 'dart:convert';

ResGetNews resGetNewsFromJson(String str) =>
    ResGetNews.fromJson(json.decode(str));

String resGetNewsToJson(ResGetNews data) => json.encode(data.toJson());

class ResGetNews {
  ResGetNews({
    this.isSuccess,
    this.message,
    this.data,
  });

  bool? isSuccess;
  String? message;
  List<Data>? data;

  factory ResGetNews.fromJson(Map<String, dynamic> json) => ResGetNews(
        isSuccess: json["is_success"] == null ? null : json["is_success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "is_success": isSuccess == null ? null : isSuccess,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.idNews,
    this.title,
    this.description,
    this.picture,
    this.dateNews,
  });

  String? idNews;
  String? title;
  String? description;
  String? picture;
  DateTime? dateNews;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idNews: json["id_news"] == null ? null : json["id_news"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        picture: json["picture"] == null ? null : json["picture"],
        dateNews: json["date_news"] == null
            ? null
            : DateTime.parse(json["date_news"]),
      );

  Map<String, dynamic> toJson() => {
        "id_news": idNews == null ? null : idNews,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "picture": picture == null ? null : picture,
        "date_news": dateNews == null ? null : dateNews!.toIso8601String(),
      };
}
