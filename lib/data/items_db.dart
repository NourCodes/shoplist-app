import '../models/category_model.dart';
import '../models/item_model.dart';
import 'categories_db.dart';

List<Items> groceryItems = [
  Items(
      id: 'a',
      name: 'Cucumber',
      quantity: 1,
      category: categories[AllCategories.vegetables]!),
  Items(
      id: 'b',
      name: 'Apples',
      quantity: 2,
      category: categories[AllCategories.fruit]!),
  Items(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories[AllCategories.meat]!),
];
