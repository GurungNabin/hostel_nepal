import 'dart:convert';

List<HosetlInfoModel> hostelModelFromJson(String str) =>
    List<HosetlInfoModel>.from(
        json.decode(str).map((x) => HosetlInfoModel.fromJson(x)));

String hostelModelToJson(List<HosetlInfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HosetlInfoModel {
  String name;
  String address;
  int location;
  int area;
  String phone;
  String type;
  List<String> images;
  List<String> imagesExtension;

  HosetlInfoModel({
    required this.name,
    required this.location,
    required this.area,
    required this.address,
    required this.phone,
    required this.type,
    required this.images,
    required this.imagesExtension,
  });

  factory HosetlInfoModel.fromJson(Map<String, dynamic> json) =>
      HosetlInfoModel(
        name: json['name'],
        location: json['location'],
        area: json['area'],
        address: json['address'],
        phone: json['phone'],
        type: json['type'],
        images: List<String>.from(json['imageUrls']),
        imagesExtension: List<String>.from(json['imageExtensions']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'location': location,
        'area': area,
        'address': address,
        'phone': phone,
        'type': type,
        'images': images,
        'imagesExtension': imagesExtension,
      };
}
