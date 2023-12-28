import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shoplist/data/categories_db.dart';
import 'package:shoplist/models/item_model.dart';
import 'package:shoplist/pages/new_item.dart';
import 'package:shoplist/widgets/grocery_list.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Items> itemsList = [];
  @override
  void initState() {
    loadItems();
    super.initState();
  }

  //fetch data from firebase and load it
  void loadItems() async {
    final url = Uri.https(
      'fluttershoplist-46e37-default-rtdb.firebaseio.com',
      'shop-list.json',
    );
    // fetching data from the URL
    final response = await http.get(url);
    // decoding the response body, which is in JSON format, into a map
    final Map<String, dynamic> dataList = json.decode(response.body);
    // create a temporary list to store Items
    final List<Items> templist = [];
    // convert the map entries to Items and add them to the temporary list
    for (final i in dataList.entries) {
      // find the matching category based on the category title in the data
      final tempCategory = categories.entries
          .firstWhere((element) => element.value.title == i.value['Category'])
          .value;

      // create Items object and add it to the temporary list
      templist.add(
        Items(
            name: i.value['name'],
            category: tempCategory,
            id: i.key,
            quantity: i.value["Quantity"]),
      );
    }
    setState(() {
      itemsList = templist;
    });
  }

  void addItem() async {
    await Navigator.of(context).push<Items>(
      MaterialPageRoute(
        builder: (context) {
          return const NewItem();
        },
      ),
    );
    loadItems();
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
