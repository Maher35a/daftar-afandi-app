import 'package:hive/hive.dart';
part 'personClass.g.dart';

@HiveType(typeId: 0)
class Person {
  @HiveField(0)
  double amount;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? imagePath;

  @HiveField(3)
  List<String> transactions;

  Person({
    required this.amount,
    required this.name,
    this.imagePath,
    List<String>? transactions,
  }) : transactions = transactions ?? [];

  copyWith({required double amount}) {}
}
