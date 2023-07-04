// To parse this JSON data, do
//
//     final leaveModel = leaveModelFromJson(jsonString);

import 'dart:convert';

LeaveModel leaveModelFromJson(String str) =>
    LeaveModel.fromJson(json.decode(str));

String leaveModelToJson(LeaveModel data) => json.encode(data.toJson());

class LeaveModel {
  int type;
  DateTime startLeave;
  DateTime endLeave;
  String? document;
  String? note;
  DateTime createdAt;
  String userId;

  LeaveModel(
      {required this.type,
      required this.startLeave,
      required this.endLeave,
      required this.document,
      required this.note,
      required this.createdAt,
      required this.userId});

  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
      type: json["type"],
      startLeave: DateTime.parse(json["startLeave"]),
      endLeave: DateTime.parse(json["endLeave"]),
      document: json["document"],
      note: json["note"],
      createdAt: DateTime.parse(json["createdAt"]),
      userId: json["userId"]);

  Map<String, dynamic> toJson() => {
        "type": type,
        "startLeave": startLeave.toIso8601String(),
        "endLeave": endLeave.toIso8601String(),
        "document": document,
        "note": note,
        "createdAt": createdAt.toIso8601String(),
        "userId": userId
      };
}
