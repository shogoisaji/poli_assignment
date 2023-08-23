import 'dart:convert';

import 'package:politec_assignment/domain/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> saveFunction(String name, int age, String mail) async {
  final prefs = await SharedPreferences.getInstance();
  final currentId = prefs.getInt('currentId') ?? 0;
  final nextId = currentId + 1;
  UserData user = UserData(id: nextId, name: name, age: age, mail: mail);
  String userJson = jsonEncode(user.toJson());
  prefs.setString("user$nextId", userJson);
  prefs.setInt('currentId', nextId);
  return userJson;
}

Future<List<UserData>> checkPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final Set<String> keys = prefs.getKeys();
  List<UserData> users = [];
  for (String key in keys) {
    if (key == 'currentId') continue;
    final json = prefs.getString(key) ?? "";
    final UserData user = UserData.fromJson(jsonDecode(json));
    users.add(user);
  }
  return users;
}

Future<String> deleteData(String key) async {
  await SharedPreferences.getInstance().then((prefs) => prefs.remove(key));
  return key;
}

Future<String> deleteAll() async {
  await SharedPreferences.getInstance().then((prefs) => prefs.clear());
  return "All data deleted";
}
