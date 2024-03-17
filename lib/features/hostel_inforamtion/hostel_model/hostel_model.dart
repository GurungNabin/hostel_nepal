import 'dart:convert';

List<HostelModel> hostelModelFromJson(String str) => List<HostelModel>.from(
    json.decode(str).map((x) => HostelModel.fromJson(x)));

String hostelModelToJson(List<HostelModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HostelModel {
  String name;
  String address;
  String email;
  String phone;

  HostelModel({
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
  });

  factory HostelModel.fromJson(Map<String, dynamic> json) => HostelModel(
        name: json['name'],
        address: json['address'],
        email: json['email'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'email': email,
        'phone': phone,
      };
}
