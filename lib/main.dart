import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loggy/loggy.dart';
import 'package:mark_pro/global.dart';
import 'package:mark_pro/pages/login_page.dart';
import 'package:mark_pro/pages/register_page.dart';
import 'package:mark_pro/pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Loggy.initLoggy(
    logOptions: const LogOptions(
      LogLevel.all,
      stackTraceLevel: LogLevel.error,
    )
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MarkPro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InitApp(),
      initialRoute: "login",
      routes: {
        "login": (context) => const LoginPage(),
        "register": (context) => const RegisterPage(),
        "main": (context) => const MainPage(),
      },
    );
  }
}


class InitApp extends StatefulWidget {
  const InitApp({Key? key}) : super(key: key);

  @override
  _InitAppState createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> with UiLoggy {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return isLogin ? const MainPage(): const LoginPage();
  }

  void _checkToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    if (token == null || JwtDecoder.isExpired(token)) {
      loggy.info("main.dart: InitApp: token expired");
      setState(() {
        isLogin = false;
      });
      return;
    }
    loggy.info("main.dart: InitApp: token reused");
    Map<String, dynamic> jwt = JwtDecoder.decode(token);
    g.username = jwt["username"].toString();
    g.token = token;
    setState(() {
      isLogin = true;
    });
  }
}