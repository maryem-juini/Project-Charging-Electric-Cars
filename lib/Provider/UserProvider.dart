import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _userId;

  String? get userId => _userId;

  setUserId(String? userId) {
    _userId = userId;
    notifyListeners();
  }
}
