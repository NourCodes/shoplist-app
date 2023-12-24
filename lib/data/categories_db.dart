import 'package:flutter/material.dart';
import '../models/category_model.dart';

const categories = {
  AllCategories.vegetables: Category(
    'Vegetables',
    Color.fromARGB(255, 50, 205, 50),
  ),
  AllCategories.fruit: Category(
    'Fruit',
    Color.fromARGB(255, 255, 165, 0),
  ),
  AllCategories.meat: Category(
    'Meat',
    Color.fromARGB(255, 255, 69, 0),
  ),
  AllCategories.dairy: Category(
    'Dairy',
    Color.fromARGB(255, 70, 130, 180),
  ),
  AllCategories.carbs: Category(
    'Carbs',
    Color.fromARGB(255, 100, 149, 237),
  ),
  AllCategories.sweets: Category(
    'Sweets',
    Color.fromARGB(255, 255, 99, 71),
  ),
  AllCategories.spices: Category(
    'Spices',
    Color.fromARGB(255, 255, 215, 0),
  ),
  AllCategories.convenience: Category(
    'Convenience',
    Color.fromARGB(255, 186, 85, 211),
  ),
  AllCategories.hygiene: Category(
    'Hygiene',
    Color.fromARGB(255, 255, 20, 147),
  ),
  AllCategories.other: Category(
    'Other',
    Color.fromARGB(255, 0, 255, 255),
  ),
};
