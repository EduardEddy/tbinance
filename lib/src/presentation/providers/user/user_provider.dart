import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _email = 'Eduardo@flutter.com';

  set setEmail(String data) {
    _email = data;
  }

  String get email => _email!;
}
