import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/class/user.dart';
import 'package:hive_test/screens/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

final myBox = Hive.box('users');

var username = TextEditingController();
var password = TextEditingController();
var repassword = TextEditingController();

void addUser() async {
  Hive.openBox('users');
  final user = User(username: username.text, password: password.text);
  await myBox.put(username.text, user);
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Input password',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    addUser();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return Login();
                        },
                      ),
                    );
                  },
                  child: Text('Register Account'))
            ],
          ),
        ),
      ),
    );
  }
}
