import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../Models/personClass.dart';
import '../../Models/storemodel/StoreModel.dart';

class FirebaseService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> syncPeopleToFirebase() async {
    final peopleBox = Hive.box<Person>('peopleBox');
    final peopleCollection = _firestore.collection('people');

    for (var person in peopleBox.values) {
      await peopleCollection.doc(person.name).set({
        'name': person.name,
        'amount': person.amount,
        'imagePath': person.imagePath,
        'transactions': person.transactions,
      });
    }
  }
  static Future<void> syncProductsToFirebase() async {
    final storeBox = Hive.box<ProductModel>('storeBox');
    final storeCollection = _firestore.collection('store');

    for (var product in storeBox.values) {
      await storeCollection.doc(product.name).set({
        'category': product.category,
        'name': product.name,
        'price': product.price,
        'quantity': product.quantity,
      });
    }
  }

  /// 🔄 مزامنة الكل
  static Future<void> syncAll() async {
    await syncPeopleToFirebase();
    await syncProductsToFirebase();
  }
}
