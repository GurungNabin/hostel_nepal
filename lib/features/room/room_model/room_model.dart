import 'dart:convert';

List<RoomSeaterModel> roomSeaterFromJson(String str) =>
    List<RoomSeaterModel>.from(
        json.decode(str).map((x) => RoomSeaterModel.fromJson(x)));

String roomSeaterToJson(List<RoomSeaterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomSeaterModel {
  int hostelId;
  String hostelRoomSeater; // Change type to String
  int total;
  int available;
  double price;
  List<String> images;
  List<String> imagesExtension; // Add imagesExtension property

  RoomSeaterModel({
    required this.hostelId,
    required this.hostelRoomSeater,
    required this.total,
    required this.available,
    required this.price,
    required this.images,
    required this.imagesExtension,
  });

  factory RoomSeaterModel.fromJson(Map<String, dynamic> json) =>
      RoomSeaterModel(
        hostelId: json['hostel_id'],
        hostelRoomSeater: json['hostel_room_seater'],
        total: json['total'],
        available: json['available'],
        price: json['price'].toDouble(), // Convert to double
        images: List<String>.from(json['images']),
        imagesExtension:
            List<String>.from(json['imagesExtension']), // Parse imagesExtension
      );

  Map<String, dynamic> toJson() => {
        'hostel_id': hostelId,
        'hostel_room_seater': hostelRoomSeater,
        'total': total,
        'available': available,
        'price': price,
        'images': images,
        'imagesExtension': imagesExtension, // Include imagesExtension in toJson
      };
}
