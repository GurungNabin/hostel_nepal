import 'dart:convert';
import 'package:hostel_nepal/common/error.dart';
import 'package:hostel_nepal/features/hostel_inforamtion/hostel_model/hostel_model.dart';
import 'package:hostel_nepal/utils.dart';
import 'package:http/http.dart' as http;

class HostelApi {
  static Future<void> createHostelInfo(HostelModel hostelData) async {
    try {
      String jsonHostelData = jsonEncode(hostelData.toJson());
      final response = await http.post(
        Uri.parse('$uri/hosteluser.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonHostelData,
      );

      if (response.statusCode == 201 || json.decode(response.body)['status']) {
        // print('Hostel info created successfully');
        print(json.decode(response.body)['data']);
      } else {
        print('Failed to create hostel information: ${response.body}');
        throw Exception('Failed to create hostel information');
      }
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }
}
