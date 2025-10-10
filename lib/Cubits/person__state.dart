part of 'person__cubit.dart';

@immutable
abstract class PersonState {}

class PersonInitial extends PersonState {}

class PersonLoaded extends PersonState {
  final List<Person> people;
  final String searchQuery;

  PersonLoaded({
    required this.people,
    this.searchQuery = "",
  });

  List<Person> get filteredPeople {
    if (searchQuery.isEmpty) return people;
    return people
        .where((p) =>
        p.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  PersonLoaded copyWith({
    List<Person>? people,
    String? searchQuery,
  }) {
    return PersonLoaded(
      people: people ?? this.people,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
