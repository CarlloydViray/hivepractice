import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/class/personAdapter.dart';
import 'package:hive_test/screens/login.dart';


void main(List<String> args) async {
  //init hive
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());

  //open box
  var box = await Hive.openBox("myBox");
  var userBox = await Hive.openBox("users");

  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
