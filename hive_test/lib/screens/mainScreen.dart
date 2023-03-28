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
  List<Map<String, dynamic>> _cartList = [];

  void getData() {
    final data = _mybox.keys.map((key) {
      final item = _mybox.get(key);
      return {
        "key": key,
        "itemName": item["itemName"],
        "itemIndex": item["itemIndex"],
      };
    }).toList();

    setState(() {
      _cartList = data.toList();
    });
  }

  void deleteData(int index) {
    _cartList.removeAt(index);
    _mybox.deleteAt(index);
    getData();
  }

  Future<void> saveData(Map<String, dynamic> newItem) async {
    await _mybox.add(newItem);
    getData();
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
                              var counter = _mybox.length + 1;
                              saveData(
                                {
                                  "itemName": shoppingCart.text,
                                  "itemIndex": counter,
                                },
                              );
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Added to shopping list!',
                              );
                              shoppingCart.clear();
                            },
                            child: Text("Add")),
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
                  final currentItem = _cartList[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(currentItem['itemName']),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  deleteData(index);
                                });
                              },
                              icon: Icon(Icons.delete_outline_rounded))
                        ],
                      ),
                    ),
                  );
                },
                itemCount: _cartList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
