import 'dart:convert';

List<HostelSeater> hostelSeaterFromJson(String str) => List<HostelSeater>.from(
    json.decode(str).map((x) => HostelSeater.fromJson(x)));

String hostelSeaterToJson(List<HostelSeater> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HostelSeater {
  int hostelId;
  int hostelRoomSeater;
  int total;
  int available;
  int price;
  String image;

  HostelSeater({
    required this.hostelId,
    required this.hostelRoomSeater,
    required this.total,
    required this.available,
    required this.price,
    required this.image,
  });

  factory HostelSeater.fromJson(Map<String, dynamic> json) => HostelSeater(
        hostelId: json['hostel_id'],
        hostelRoomSeater: json['hostel_room_seater'],
        total: json['total'],
        available: json['available'],
        price: json['price'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'hostel_id': hostelId,
        'hostel_room_seater': hostelRoomSeater,
        'total': total,
        'available': available,
        'price': price,
        'image': image,
      };
}
