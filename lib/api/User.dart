
import 'package:dio/dio.dart';
import 'package:loggy/loggy.dart';
import 'package:mark_pro/utils/Request.dart';

dynamic login(Map<String, dynamic> data) async {
  var resp = await request("/login", "POST", body: data);
  if (resp == null) {
    logError("api.User.dart: login: response is null!");
    return null;
  }
  return resp.data;
}