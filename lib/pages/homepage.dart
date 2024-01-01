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
  bool isLoading = true;
  List<Items> itemsList = [];
  String? error;
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
    if (response.statusCode >= 400) {
      setState(() {
        error = "Failed to fetch fata. Try Again Later";
      });
    }
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
      isLoading = false;
    });
  }

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

  void removeItem(Items item) async {
    final index = itemsList.indexOf(item);
    Items? deletedItem;

    //before removing the item from the itemsList, store a reference to the deleted item for the undo action
    setState(() {
      deletedItem = item;
      itemsList.remove(item);
    });

    //delete the item from Firebase Realtime Database
    final url = Uri.https(
      'fluttershoplist-46e37-default-rtdb.firebaseio.com',
      'shop-list/${item.id}.json',
    );
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      //if there's an error with the Firebase delete, show a message
      print("Error: ${response.body}");
    } else {
      // if deletion is successful, show a SnackBar with Undo option
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(
            seconds: 12,
          ),
          content: const Text("Item has been deleted"),
          action: SnackBarAction(
              label: "Undo",
              onPressed: () async {
                //insert the deleted item back into the itemsList
                if (deletedItem != null) {
                  setState(() {
                    itemsList.insert(index, deletedItem!);
                  });

                  // upload the data back to Firebase
                  final undoUrl = Uri.https(
                    'fluttershoplist-46e37-default-rtdb.firebaseio.com',
                    'shop-list/${deletedItem!.id}.json',
                  );
                  await http.put(
                    undoUrl,
                    body: json.encode(
                      {
                        'name': deletedItem!.name,
                        'Category': deletedItem!.category.title,
                        'Quantity': deletedItem!.quantity,
                      },
                    ),
                  );
                }
              }),
        ),
      );
    }
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
    if (isLoading) {
      screen = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (error != null) {
      screen = Center(
        child: Text(error!, style: Theme.of(context).textTheme.titleMedium),
      );
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
