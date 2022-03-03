import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:mark_pro/api/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with UiLoggy {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  bool loginButtonHover = false;

  String? validUsername(String? value) {
    if (value == null) {
      return "用户名不能为空";
    }
    int min = 6, max = 20;
    bool valid = min <= value.length && value.length <= max;
    return valid ? null : "用户名长度需大于等于 $min 且小于等于 $max";
  }

  String? validPassword(String? value) {
    if (value == null) {
      return "密码不能为空";
    }
    bool valid = value.length >= 6;
    return valid ? null : "密码长度需大于等于 6";
  }

  String? validEmail(String? value) {
    if (value == null) {
      return "邮箱格式错误";
    }
    List<String> emailSlice = value.split("@");
    bool valid = emailSlice.length == 2;
    return valid ? null : "邮箱格式错误";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/sakura.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.1,
              left: MediaQuery.of(context).size.width * 0.1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                        child: const Text(
                        "用户注册",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: username,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: "用户名",
                              hintText: "请输入用户名",
                            ),
                            validator: validUsername,
                          ),
                          TextFormField(
                            controller: password,
                            obscureText: true,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: "密码",
                              hintText: "请输入密码",
                            ),
                            validator: validPassword,
                          ),
                          TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: "邮箱",
                              hintText: "请输入邮箱",
                            ),
                            validator: validEmail,
                          ),
                          const SizedBox(height: 15,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: ElevatedButton(
                              child: const Text("注册"),
                              onPressed: () async {
                                // 表单判断
                                var formState = _formKey.currentState as FormState;
                                if (!formState.validate()) {
                                  return;
                                }
                                // 注册请求
                                var resp = await register({
                                  "username": username.text,
                                  "password": password.text,
                                  "email": email.text,
                                });
                                if (resp == null || resp.statusCode != 200) {
                                  return;
                                }
                                Navigator.pop(context);
                                // TODO: 增加注册成功 dialog
                              },
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "已有账号，点击登录",
                              style: TextStyle(
                                color: loginButtonHover ? Colors.blue[800] : Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                shadows: const <Shadow>[
                                  Shadow(color: Colors.black),
                                ],
                              ),
                            ),
                            onHover: (hover) {
                              setState(() {
                                loginButtonHover = hover;
                              });
                            },
                            onPressed: () {
                              loggy.debug("goto login page(click 'have an account')");
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}