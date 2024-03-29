import 'dart:convert';
import 'dart:io';
import 'package:hostel_nepal/constants/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;


class RoomApi {
  static Future<String> sendData({
    required List<Map<String, dynamic>> roomDataList,
    required List<String> images,
    required int hostelId,
  }) async {
    try {
      for (int i = 0; i < roomDataList.length; i++) {
        Map<String, dynamic> roomData = roomDataList[i];

        // Convert XFile objects to base64 strings
        List<String> base64Images = [];
        List<String> imagesExtensions = [];

        for (String imagePath in images) {
          List<int> imageBytes = File(imagePath).readAsBytesSync();
          String base64Image = base64Encode(imageBytes);
          base64Images.add(base64Image);
          imagesExtensions.add(path.extension(imagePath));
        }

        // Add base64-encoded images to the room data
        roomData['images'] = base64Images;

        // Make the HTTP request with the modified roomData
        final res = await http.post(
          Uri.parse('$uri/inserthostelseaterinfo.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(roomDataList),
        );

        if (res.statusCode == 201) {
          // Handle success response
          print('Room info created successfully');
          print(json.decode(res.body));
        } else {
          // Handle other status codes
          print('Failed to create room information: ${res.body}');
          throw Exception('Failed to create room information');
        }
      }

      // Return a response after all iterations are completed
      return 'All data sent successfully';
    } catch (e) {
      // Handle errors
      throw Exception('Error: $e');
    }
  }
}
