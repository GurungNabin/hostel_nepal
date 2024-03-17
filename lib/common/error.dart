

import 'package:flutter/foundation.dart';

class ErrorHandler {
  static void handleError(dynamic e) {
    if (kDebugMode) {
      print('Error occurred: $e');
    }
   
  }
}
