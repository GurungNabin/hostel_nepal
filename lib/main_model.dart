// import 'dart:convert';

// class HostelData {
//   String hostelName = '';
//   String address = '';
//   String contactEmail = '';
//   String contactPhone = '';
//   List<String> facilities = [];
//   List<RoomData> rooms = [];
//   List<String> rules = [];
//   ImageModel? imageModel; // Updated to use ImageModel instead of File

//   HostelData({
//     this.hostelName = '',
//     this.address = '',
//     this.contactEmail = '',
//     this.contactPhone = '',
//     this.facilities = const [],
//     this.rooms = const [],
//     this.rules = const [],
//     this.imageModel,
//   });

//   factory HostelData.fromJson(Map<String, dynamic> json) {
//     return HostelData(
//       hostelName: json['hostelName'] ?? '',
//       address: json['address'] ?? '',
//       contactEmail: json['contactEmail'] ?? '',
//       contactPhone: json['contactPhone'] ?? '',
//       facilities: json['facilities'] != null
//           ? List<String>.from(json['facilities'])
//           : [],
//       rooms: json['rooms'] != null
//           ? List<RoomData>.from(json['rooms'].map((x) => RoomData.fromJson(x)))
//           : [],
//       rules: json['rules'] != null ? List<String>.from(json['rules']) : [],
//       imageModel: json['imageModel'] != null
//           ? ImageModel.fromJson(json['imageModel'])
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'hostelName': hostelName,
//       'address': address,
//       'contactEmail': contactEmail,
//       'contactPhone': contactPhone,
//       'facilities': facilities,
//       'rooms': rooms.map((room) => room.toJson()).toList(),
//       'rules': rules,
//       'imageModel': imageModel?.toJson(),
//     };
//   }
// }

// class RoomData {
//   String roomType = '';
//   int capacity = 0;
//   bool available = false;
//   double price = 0.0;

//   RoomData({
//     this.roomType = '',
//     this.capacity = 0,
//     this.available = false,
//     this.price = 0.0,
//   });

//   factory RoomData.fromJson(Map<String, dynamic> json) {
//     return RoomData(
//       roomType: json['roomType'] ?? '',
//       capacity: json['capacity'] ?? 0,
//       available: json['available'] ?? false,
//       price: json['price'] ?? 0.0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'roomType': roomType,
//       'capacity': capacity,
//       'available': available,
//       'price': price,
//     };
//   }
// }

// class ImageModel {
//   String imageUrl;

//   ImageModel({required this.imageUrl});

//   factory ImageModel.fromJson(Map<String, dynamic> json) {
//     return ImageModel(imageUrl: json['imageUrl'] ?? '');
//   }

//   Map<String, dynamic> toJson() {
//     return {'imageUrl': imageUrl};
//   }
// }

// List<HostelData> hostelDataFromJson(String str) =>
//     List<HostelData>.from(json.decode(str).map((x) => HostelData.fromJson(x)));

// String hostelDataToJson(List<HostelData> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
