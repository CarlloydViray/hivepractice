import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  final _mybox = Hive.box("myBox");

  var userName = TextEditingController();

  var firstName = TextEditingController();

  var lastName = TextEditingController();

  var address = TextEditingController();

  var tempValUsername;

  void saveData(username, firstname, lastname, address) {
    _mybox.put('username', username);
    _mybox.put('firstname', firstname);
    _mybox.put('lastname', lastname);
    _mybox.put('address', address);
  }

  void getData() {
    var tempUsername = _mybox.get('username');
    userName.text = tempUsername;

    var tempFirstname = _mybox.get('firstname');
    firstName.text = tempFirstname;

    var tempLastname = _mybox.get('lastname');
    lastName.text = tempLastname;

    var tempAddress = _mybox.get('address');
    address.text = tempAddress;

    print(_mybox.get('username'));
    print(_mybox.get('firstname'));
    print(_mybox.get('lastname'));
    print(_mybox.get('address'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hive Flutter"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    saveData(userName.text, firstName.text, lastName.text,
                        address.text);

                    userName.clear();
                    firstName.clear();
                    lastName.clear();
                    address.clear();

                    getData();
                  });
                },
                icon: Icon(Icons.save_alt_rounded))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: userName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Username'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: firstName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Firstname'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: lastName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Last Name'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: address,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Address'),
              ),
            ],
          ),
        ));
  }
}
