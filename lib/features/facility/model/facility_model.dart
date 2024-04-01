import 'dart:convert';

List<FacilityModel> facilityFromJson(String str) => List<FacilityModel>.from(
    json.decode(str).map((x) => FacilityModel.fromJson(x)));

String facilityToJson(List<FacilityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FacilityModel {
  String id;
  String title;

  FacilityModel({
    required this.id,
    required this.title,
  });

  factory FacilityModel.fromJson(Map<String, dynamic> json) => FacilityModel(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
