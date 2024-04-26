import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserHelper {
  final String _userKey = 'user';
  Future<List<Map<String, String>>> getUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usersJson = prefs.getString(_userKey);
    final List<Map<String, String>> typedUsersList = [];

    if (usersJson != null) {
      final List<dynamic> usersList = json.decode(usersJson);
      for (var user in usersList) {
        if (user is Map<String, dynamic>) {
          typedUsersList.add(user.cast<String, String>());
        }
      }
    }

    return typedUsersList;
  }

  Future<bool> registerUser(String email, String password) async {
    final List<Map<String, String>> users = await getUsers();
    for (final user in users) {
      if (user['email'] == email) {
        return false;
      }
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    users.add({'email': email, 'password': password});
    final String usersJson = json.encode(users);
    return await prefs.setString(_userKey, usersJson);
  }
}
