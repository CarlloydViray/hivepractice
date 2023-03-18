import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickalert/quickalert.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  final _mybox = Hive.box("myBox");

  var shoppingCart = TextEditingController();
  List<String> _cartList = [];
  List<String> readBox = [];

  void saveData(shoppingAdd) {
    _mybox.add(shoppingAdd);
  }

  void getData() {
    print(Hive.box("myBox").values.toString());
  }

  void deleteData() {
    _mybox.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Item"),
          leading: Icon(Icons.check_circle_outline),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: shoppingCart,
                          decoration: InputDecoration(
                            labelText: "Item",
                            hintText: "Input Text",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      text:
                                          'Added to cart!',
                                    );
                                    _cartList.add(shoppingCart.text);
                                    saveData(_cartList);
                                    shoppingCart.clear();
                                  });
                                },
                                child: Text("Add")),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    getData();
                                  });
                                },
                                child: Text("review")),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    deleteData();
                                  _cartList.clear();
                                  });
                                },
                                child: Text("delete all")),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_mybox.get(index).toString()),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete_outline_rounded))
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: _mybox.length,
                  ),
                ),
              ],
            )));
  }
}
