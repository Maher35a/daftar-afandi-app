import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../Models/personClass.dart';
import '../features/Hive/hive_service.dart';
part 'person__state.dart';

class PersonCubit extends Cubit<PersonState> {
  PersonCubit() : super(PersonInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void loadPeople() {
    final box = HiveService.getPeopleBox();
    emit(PersonLoaded(people: box.values.toList()));
  }
  Future<void> addPerson(Person person) async {
    if (person.amount == 0) return;

    final box = HiveService.getPeopleBox();
    await box.add(person);
    loadPeople();

    try {
      await _firestore.collection('people').add({
        'name': person.name,
        'amount': person.amount,
        'imagePath': person.imagePath,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("✅ تم رفع العميل (${person.name}) إلى Firestore بنجاح");
    } catch (e) {
      print("❌ خطأ أثناء رفع العميل إلى Firestore: $e");
    }
  }
  Future<void> deletePerson(int index) async {
    final box = HiveService.getPeopleBox();
    final person = box.getAt(index);

    if (person != null) {
      try {
        final query = await _firestore
            .collection('people')
            .where('name', isEqualTo: person.name)
            .where('amount', isEqualTo: person.amount)
            .get();

        for (var doc in query.docs) {
          await doc.reference.delete();
        }

        print("🗑️ تم حذف العميل من Firestore");
      } catch (e) {
        print("⚠️ خطأ أثناء حذف العميل من Firestore: $e");
      }

      box.deleteAt(index);
      loadPeople();
    }
  }
  void search(String query) {
    if (state is PersonLoaded) {
      final current = state as PersonLoaded;
      emit(current.copyWith(searchQuery: query));
    }
  }

  void updatePersonAmount(int index, double newAmount) {
    final box = HiveService.getPeopleBox();
    final person = box.getAt(index);

    if (person != null) {
      final updated = person.copyWith(amount: newAmount);

      if (updated.amount == 0) {
        box.deleteAt(index);
      } else {
        box.putAt(index, updated);
      }

      loadPeople();
    }
  }
}
