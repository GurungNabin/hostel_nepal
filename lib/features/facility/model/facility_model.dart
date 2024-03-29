import 'dart:convert';

List<Facility> facilityFromJson(String str) =>
    List<Facility>.from(json.decode(str).map((x) => Facility.fromJson(x)));

String facilityToJson(List<Facility> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Facility {
  String id;
  String title;

  Facility({
    required this.id,
    required this.title,
  });

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
