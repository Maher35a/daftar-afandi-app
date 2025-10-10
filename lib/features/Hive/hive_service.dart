import 'package:hive_flutter/hive_flutter.dart';
import '../../Models/personClass.dart';
import '../../Models/storemodel/StoreModel.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(PersonAdapter());
    Hive.registerAdapter(ProductModelAdapter());

    await Hive.openBox<Person>('peopleBox');
    await Hive.openBox<ProductModel>('storeBox');
  }

  static Box<Person> getPeopleBox() => Hive.box<Person>('peopleBox');
  static Box<ProductModel> getStoreBox() => Hive.box<ProductModel>('storeBox');
}
