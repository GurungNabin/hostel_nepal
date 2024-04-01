import 'dart:convert';

import 'package:flutter/material.dart';

import '../userModel/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    id: 0,
    email: '',
    token: '',
    phoneNumber: '',
    username: '',
  );

  UserModel get user => _user;

  void setUser(String user) {
    _user = UserModel.fromJson(jsonDecode(user));
    notifyListeners();
  }

  void setUserFromModel(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
