import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoplist/models/item_model.dart';
import '../data/items_db.dart';

class GroceryList extends StatelessWidget {
  final List<Items> allItems;
  const GroceryList({Key? key, required this.allItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allItems.length,
      itemBuilder: (context, index) => ListTile(
        leading: SizedBox.square(
            dimension: 20,
            child: ColoredBox(
              color: allItems[index].category.color,
            )),
        title: Text(allItems[index].name),
        trailing: Text(allItems[index].quantity.toString()),
      ),
    );
  }
}
