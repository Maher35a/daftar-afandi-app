import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Models/personClass.dart';
import '../../features/Hive/hive_service.dart';
import '../person__cubit.dart';

part 'update_person_state.dart';

class UpdatePersonCubit extends Cubit<UpdatePersonState> {
  UpdatePersonCubit({required this.person, required this.index})
    : super(UpdatePersonInitial(person));

  final Person person;
  final int index;

  void updateAmount(double value, String note, PersonCubit personCubit) {
    person.amount += value;

    person.transactions ??= [];

    final now = DateTime.now();
    final formattedDate =
        "${now.day}/${now.month}/${now.year} - ${now.hour % 12 == 0 ? 12 : now.hour % 12}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";

    person.transactions!.insert(
      0,
      "$note: ${value.toStringAsFixed(2)} | $formattedDate",
    );
    saveChanges();
    emit(UpdatePersonUpdated(person));

    personCubit.loadPeople();
  }

  void saveChanges() {
    final box = HiveService.getPeopleBox();
    box.putAt(index, person);
  }
}
