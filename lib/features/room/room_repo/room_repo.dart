import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hostel_nepal/common/error.dart';
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

// class RoomApi {
//   Future<void> sendData({
//     required BuildContext context,
//     required List<Map<String, dynamic>> roomDataList,
//     required List<XFile> imageUrls,
//   }) async {
//     try {
//       for (int i = 0; i < roomDataList.length; i++) {
//         Map<String, dynamic> roomData = roomDataList[i];

//         // Add image URLs to the room data
//         roomData['images'] = imageUrls;

//         http.Response res = await http.post(
//           Uri.parse('$uri/hostelinfo.php'), // Use the API URL directly here
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: jsonEncode(roomData), // Convert data to JSON before sending
//         );
//         print(res.body);
//         print('Sucessfully upload');
//         if (res.statusCode != 200) {
//           throw Exception('Failed to load room data');
//         }
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }

// class RoomApi {
//   Future<String> sendData({
//     required BuildContext context,
//     required List<Map<String, dynamic>> roomDataList,
//     required List<XFile> imageUrls,
//   }) async {
//     try {
//       for (int i = 0; i < roomDataList.length; ) {
//         Map<String, dynamic> roomData = roomDataList[i];

//         // Add image URLs to the room data
//         roomData['images'] = imageUrls;

//         http.Response res = await http.post(
//           Uri.parse('$uri/hostelinfo.php'), // Use the API URL directly here
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: jsonEncode(roomData), // Convert data to JSON before sending
//         );
//         // print(res.body);
//         // print('Successfully uploaded');
//         if (res.statusCode == 200) {
//           print(jsonDecode(res.body)['message']);

//         }else if(res.statusCode == 400){
//            print(jsonDecode(res.body)['message']);

//         }

//         return res.body; // Return the response from the server
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//     return ''; // Return an empty string if no response is received (optional)
//   }
// }

class RoomApi {
  Future<String> sendData({
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
          Uri.parse(
              '$uri/inserthostelseaterinfo.php'), // Use the API URL directly here
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(roomData), // Convert data to JSON before sending
        );

        // Check the response and print statements
        if (res.statusCode == 201 || json.decode(res.body)['message']) {
          print('Hostel info created successfully');
          print(json.decode(res.body));
        } else {
          print('Failed to create hostel information: ${res.body}');
          throw Exception('Failed to create hostel information');
        }
      }

      // Return a response after all iterations are completed
      return 'All data sent successfully';
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}


// class RoomApi {
//   static Future<void> createHostelInfo( roomData) async {
//     try {
//       String jsonHostelData = jsonEncode(roomData.toJson());
//       final response = await http.post(
//         Uri.parse('$uri/hostelinfo.php'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonHostelData,
//       );

//       if (response.statusCode == 201 || json.decode(response.body)['status']) {
//         // print('Hostel info created successfully');
//         print(json.decode(response.body)['message']);
//       } else {
//         print('Failed to create hostel information: ${response.body}');
//         throw Exception('Failed to create hostel information');
//       }
//     } catch (e) {
//       ErrorHandler.handleError(e);
//     }
//   }
// }
