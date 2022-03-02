import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:mark_pro/api/User.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with UiLoggy {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool registerButtonHover = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                // 背景图片
                image: DecorationImage(
                  image: AssetImage("assets/sakura.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.35,
                ),
              ),
            ),
            // 注册页面元素
            Positioned(
              top: MediaQuery.of(context).size.width * 0.1,
              left: MediaQuery.of(context).size.width * 0.1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      "MarkPro",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "用户名",
                        hintText: "请输入密码",
                      ),
                      onChanged: (username) {
                        this.username.text = username;
                      },
                    ),
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "密码",
                        hintText: "请输入密码",
                      ),
                      onChanged: (password) {
                        this.password.text = password;
                      }
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      child: ElevatedButton(
                        child: const Text("登录"),
                        onPressed: () async {
                          loggy.debug("login username: " + this.username.text);
                          loggy.debug("login password: " + this.password.text);
                          var resp = await login({"username": username.text, "password": password.text});
                          loggy.info(resp);
                        },
                      ),
                    ),
                    const SizedBox(height: 5,),
                    TextButton(
                      child: Text(
                        "没有账号，点击注册",
                        style: TextStyle(
                          color: registerButtonHover ? Colors.blue[800] : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          shadows: const <Shadow>[
                            Shadow(color: Colors.black)
                          ]
                        ),
                      ),
                      onHover: (hover) {
                        setState(() {
                          registerButtonHover = hover;
                        });
                      },
                      onPressed: () {
                        loggy.debug("goto register page");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}