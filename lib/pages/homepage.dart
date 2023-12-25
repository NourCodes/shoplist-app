import 'package:flutter/material.dart';
import 'package:shoplist/models/item_model.dart';
import 'package:shoplist/pages/new_item.dart';
import 'package:shoplist/widgets/grocery_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Items> itemsList = [];

  void addItem() async {
    final newItem = await Navigator.of(context).push<Items>(
      MaterialPageRoute(
        builder: (context) {
          return const NewItem();
        },
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      itemsList.add(newItem);
    });
  }

  void removeItem(Items item) {
    final index = itemsList.indexOf(item);
    setState(() {
      itemsList.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          seconds: 12,
        ),
        content: const Text("Item has been deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              itemsList.insert(index, item);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget screen = Center(
        child: Text("No items Found",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                )));
    if (itemsList.isNotEmpty) {
      screen = GroceryList(allItems: itemsList, onRemove: removeItem);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groceries"),
        actions: [
          IconButton(
            onPressed: addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: screen,
    );
  }
}
