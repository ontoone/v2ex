import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String userName = "";
  String password = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: loginBody(),
      ),
    );
  }

  loginBody() => SingleChildScrollView(
        child: loginFields(),
      );

  loginFields() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextField(
                controller: nameController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "输入用户名",
                  labelText: "用户名",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "输入密码",
                  labelText: "密码",
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            CachedNetworkImage(
              height: 45.0,
              fit: BoxFit.cover,
              imageUrl: "https://www.v2ex.com/_captcha?once=68918",
              placeholder: CircularProgressIndicator(),
              httpHeaders: {
                "user-agent":
                    "Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1"
              },
              errorWidget: Icon(Icons.access_alarm),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                controller: codeController,
                decoration: InputDecoration(
                  hintText: "输入验证码",
                  labelText: "验证码",
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(12.0),
                shape: StadiumBorder(),
                child: Text(
                  "登录",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
                onPressed: () {
                  //todo 登录
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      );
}
