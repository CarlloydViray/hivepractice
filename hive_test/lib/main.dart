import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'mainScreen.dart';

void main(List<String> args) async {

  //init hive
  await Hive.initFlutter();

  //open box
  var box = await Hive.openBox("myBox");
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainScreen(),
    );
  }
}