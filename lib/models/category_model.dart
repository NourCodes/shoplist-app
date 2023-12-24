import 'package:flutter/material.dart';

enum AllCategories {
  other,
  carbs,
  dairy,
  meat,
  sweets,
  convenience,
  spices,
  hygiene,
  fruit,
  vegetables,
}

class Category {
  final String title;
  final Color color;
  const Category(this.title, this.color);
}
