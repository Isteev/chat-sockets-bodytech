// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    required this.author,
    required this.message,
    required this.room,
    required this.time,
    this.state = 'sending',
  });

  String author;
  String message;
  int room;
  String time;
  String state;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        author: json["author"].toString(),
        message: json["message"].toString(),
        room: json["room"].runtimeType == int
            ? json['room']
            : int.parse(json["room"]),
        time: json["time"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "message": message,
        "room": room,
        "time": time,
      };
}
