import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:loggy/loggy.dart';

const String baseURL = "http://10.0.2.2:5000";

Future<Response?> request(
  String path, String method, {
  Map<String, dynamic>? param,
  Map<String, dynamic>? body,
  String? token,
}) async {
  // ignore: prefer_typing_uninitialized_variables
  var resp;
  Dio dio = Dio();
  String _path = baseURL + path;
  String _body = jsonEncode(body);
  Map<String, dynamic> _header = token == null ? {} : {"Token": token};
  try {
    switch (method) {
      case "POST":
        resp = await dio.post(
          _path, data: _body, queryParameters: param,
          options: Options(headers: _header),
        );
        return resp;
      case "PUT":
        resp = await dio.put(
          _path, data: _body, queryParameters: param,
          options: Options(headers: _header),
        );
        return resp;
      case "DELETE":
        resp = await dio.delete(
          _path, data: _body, queryParameters: param,
          options: Options(headers: _header),
        );
        return resp;
      default:
        resp = await dio.get(
          _path, queryParameters: param,
          options: Options(headers: _header),
        );
        return resp;
    }
  } on DioError catch (e) {
    // 处理 DioError
    logError(e.error);
    logError("request.path: " + path);
    logError("request.method: " + method);
    logError("request.param: " + param.toString());
    logError("request.body: " + body.toString());
    if (e.response != null) {
      logError("response.headers: " + e.response!.headers.toString());
      logError("response.data: " + e.response!.data.toString());
    } else {
      logError("response is null!");
      logError("response.message: " + e.message);
    }
  } catch (e) {
    // 处理其他 Error
    logError("unknown error: " + e.toString());
  }
  return null;
}