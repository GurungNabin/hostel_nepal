
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostel_nepal/constants/global_variables.dart';
import 'package:hostel_nepal/features/facility/model/facility_model.dart';

import 'package:http/http.dart' as http;

final facilityRepositoryProvider =
    Provider<FacilityService>((ref) => FacilityService());

class FacilityService {
  Future<List<FacilityModel>> getFacility(
      ) async {
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/getallfacilities.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);

      if (res.statusCode == 200) {
        return facilityFromJson(res.body);
      } else {
        throw Exception('Failed to load facility data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
