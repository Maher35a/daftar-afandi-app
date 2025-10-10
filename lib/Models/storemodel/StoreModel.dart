import 'package:hive/hive.dart';

part 'StoreModel.g.dart';

@HiveType(typeId: 1) 
class ProductModel extends HiveObject {
  @HiveField(0)
  String category;

  @HiveField(1)
  String name;

  @HiveField(2)
  double price;

  @HiveField(3)
  int quantity;

  ProductModel({
    required this.category,
    required this.name,
    required this.price,
    required this.quantity,
  });
}
