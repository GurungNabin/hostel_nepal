import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hostel_nepal/utils.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// class RoomApi {
//   Future<void> sendData(
//       {required BuildContext context,
//       required List<Map<String, dynamic>> roomDataList,
//       required List<Map<String, dynamic>> data}) async {
//     try {
//       for (var roomData in roomDataList) {
//         http.Response res = await http.post(
//           Uri.parse('$uri/hostelinfo.php'),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: jsonEncode(roomData), // Convert data to JSON before sending
//         );
//         print(res.body);
//         Exception('Sucessful send');

//         if (res.statusCode != 200) {
//           throw Exception('Failed to load room data');
//         }
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }

class RoomApi {
  Future<void> sendData({
    required BuildContext context,
    required List<Map<String, dynamic>> roomDataList,
    required List<XFile> imageUrls,
  }) async {
    try {
      for (int i = 0; i < roomDataList.length; i++) {
        Map<String, dynamic> roomData = roomDataList[i];

        // Add image URLs to the room data
        roomData['images'] = imageUrls;

        http.Response res = await http.post(
          Uri.parse('$uri/hostelinfo.php'), // Use the API URL directly here
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(roomData), // Convert data to JSON before sending
        );
        print(res.body);
        print('Sucessfully upload');
        if (res.statusCode != 200) {
          throw Exception('Failed to load room data');
        }
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
