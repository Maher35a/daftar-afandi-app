part of 'update_person_cubit.dart';

@immutable
abstract class UpdatePersonState {}

class UpdatePersonInitial extends UpdatePersonState {
  final Person person;
  UpdatePersonInitial(this.person);
}

class UpdatePersonUpdated extends UpdatePersonState {
  final Person person;
  UpdatePersonUpdated(this.person);
}