

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/class/user.dart';
import 'package:hive_test/screens/mainScreen.dart';
import 'package:hive_test/screens/register.dart';
import 'package:quickalert/quickalert.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final myBox = Hive.box('users');
var username = TextEditingController();
var password = TextEditingController();

void login(BuildContext context) async {
  await Hive.openBox('users');
  if (myBox.containsKey(username.text)) {
    final user = await myBox.get(username.text) as User;
    if (user.password == password.text) {
      Navigator.push(context, CupertinoPageRoute(builder: (context){
        return mainScreen();
      }));
    } else {
      QuickAlert.show(context: context, type: QuickAlertType.error, text: 'Incorrect Password');
    }
  } else {
    QuickAlert.show(context: context, type: QuickAlertType.error, text: 'User not found');
  }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: username,
              decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Input username',
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextField(
              controller: password,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Input password',
                  border: OutlineInputBorder()),
            ),
            ElevatedButton(
                onPressed: () {
                  login(context);
                },
                child: Text('Login')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) {
                        return Register();
                      },
                    ),
                  );
                },
                child: Text('Register new account'))
          ],
        ),
      ),
    ));
  }
}
