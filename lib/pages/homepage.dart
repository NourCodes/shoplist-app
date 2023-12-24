import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoplist/widgets/grocery_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groceries"),
      ),
      body: const GroceryList(),
    );
  }
}
