// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    String email;
    String employeeId;
    String name;
    String phone;
    String position;
    String? photo;

    ProfileModel({
        required this.email,
        required this.employeeId,
        required this.name,
        required this.phone,
        required this.position,
        required this.photo,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        email: json["email"],
        employeeId: json["employeeId"],
        name: json["name"],
        phone: json["phone"],
        position: json["position"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "employeeId": employeeId,
        "name": name,
        "phone": phone,
        "position": position,
        "photo": photo,
    };
}
