import 'package:flutter/material.dart';
import 'package:shoplist/models/item_model.dart';

class GroceryList extends StatelessWidget {
  final List<Items> allItems;
  final void Function(Items item) onRemove;
  GroceryList({Key? key, required this.allItems, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allItems.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Colors.red.shade600,
          child: const Icon(Icons.delete),
        ),
        onDismissed: (direction) => onRemove(allItems[index]),
        key: ValueKey(allItems[index].id),
        child: ListTile(
          leading: SizedBox.square(
              dimension: 20,
              child: ColoredBox(
                color: allItems[index].category.color,
              )),
          title: Text(allItems[index].name),
          trailing: Text(allItems[index].quantity.toString()),
        ),
      ),
    );
  }
}
