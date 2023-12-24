import 'category_model.dart';

class Items {
  final String id;
  final String name;
  final int quantity;
  final Category category;
  const Items({
    required this.name,
    required this.category,
    required this.id,
    required this.quantity,
  });
}
