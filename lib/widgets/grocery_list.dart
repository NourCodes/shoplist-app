import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/items_db.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (context, index) => ListTile(
        leading: SizedBox.square(
            dimension: 20,
            child: ColoredBox(
              color: groceryItems[index].category.color,
            )),
        title: Text(groceryItems[index].name),
        trailing: Text(groceryItems[index].quantity.toString()),
      ),
    );
  }
}
