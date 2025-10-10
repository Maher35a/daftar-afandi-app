import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../Models/personClass.dart';
import '../features/Hive/hive_service.dart';

part 'person__state.dart';

class PersonCubit extends Cubit<PersonState> {
  PersonCubit() : super(PersonInitial());

  void loadPeople() {
    final box = HiveService.getPeopleBox();
    emit(PersonLoaded(people: box.values.toList()));
  }

  void addPerson(Person person) {
    if (person.amount == 0) {
      return;
    }

    final box = HiveService.getPeopleBox();
    box.add(person);
    loadPeople();
  }
  void deletePerson(int index) {
    final box = HiveService.getPeopleBox();
    box.deleteAt(index);
    loadPeople();
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
        box.putAt(index, updated);
      }

      loadPeople();
    }
  }
}
