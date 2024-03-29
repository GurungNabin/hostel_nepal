import 'dart:convert';
import 'dart:io';
import 'package:hostel_nepal/features/hostel/hostel_model/hosel_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class HostelApi {
  static Future<String> createHostelInfo(
    HosetlInfoModel hostelData,
    List<String> imagePath,
  ) async {
    try {
      List<String> base64Images = [];
      List<String> imagesExtensions = [];

      for (String imagePath in imagePath) {
        List<int> imageBytes = File(imagePath).readAsBytesSync();

        String base64Image = base64Encode(imageBytes);

        base64Images.add(base64Image);
        imagesExtensions.add(path.extension(imagePath));
      }
      // print(imagesExtensions);

      hostelData.images = base64Images;
      hostelData.imagesExtension = imagesExtensions;

      String jsonHostelData = jsonEncode(hostelData.toJson());
      final response = await http.post(
        Uri.parse('https://www.collegesnepal.com/api/inserthostelinfo.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonHostelData,
      );

      if (response.statusCode == 201) {
        // print('Hostel info created successfully');
        print(json.decode(response.body)['data']);
        // print(response.body);
        final responseData = json.decode(response.body);
        final hostelId =
            responseData['hid']; // Assuming the hostel ID is returned as 'id'
        print('Hostel info created successfully with id: $hostelId');
        return hostelId;
      } else {
        print('Failed to create hostel information: ${response.body}');
        throw Exception('Failed to create hostel information');
      }
    } catch (e) {
      print('Error creating hostel information: $e');
      throw e; // rethrow the exception for the caller to handle
    }
  }
}
