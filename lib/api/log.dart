import 'package:dio/dio.dart';
import 'package:loggy/loggy.dart';
import 'package:mark_pro/utils/request.dart';

/// simpleTodo
/// request:
///   param:
///     simple: bool
///     jwt: string
///   headers:
///     token: string
/// response:
///   body:
///     today_done: int     # task done at tody
///     todo_1d: int        # ddl 24h
///     todo_3d: int        # ddl 72h
///     todo_7d: int        # ddl 1week
Future<Response?> simpleTodo(Map<String, dynamic> data) async {
  var resp = await request(
    "/todo_info", "GET",
    param: {"simple": "true", "username": data["username"]},
    token: data["token"],
  );
  if (resp == null) {
    logError("api.log.dart: simpleTodo: response is null!");
  }
  return resp;
}