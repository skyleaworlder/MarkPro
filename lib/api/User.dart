import 'package:dio/dio.dart';
import 'package:loggy/loggy.dart';
import 'package:mark_pro/utils/request.dart';

Future<Response?> login(Map<String, dynamic> data) async {
  var resp = await request("/login", "POST", body: data);
  if (resp == null) {
    logError("api.User.dart: login: response is null!");
  }
  return resp;
}


Future<Response?> register(Map<String, dynamic> data) async {
  var resp = await request("/register", "POST", body: data);
  if (resp == null) {
    logError("api.User.dart: register: response is null!");
  }
  return resp;
}