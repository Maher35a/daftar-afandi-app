import 'package:daftar_afandi_app/features/PeopleList/persontile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Cubits/person__cubit.dart';
import '../../Models/personClass.dart';

class PersonList extends StatelessWidget {
  const PersonList({super.key, required this.people});

  final List<Person> people;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 88),
      itemCount: people.length,
      itemBuilder: (context, index) {
        final person = people[index];

        return Dismissible(
          key: ValueKey("${person.name}-$index"),
          direction: DismissDirection.horizontal,
          background: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (_) async {
            final ok = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("تأكيد الحذف"),
                content: Text("هل تريد حذف ${person.name}؟"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text("إلغاء"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text("حذف"),
                  ),
                ],
              ),
            );
            return ok ?? false;
          },
          onDismissed: (_) {
            context.read<PersonCubit>().deletePerson(index);
          },
          child: PersonTile(person: person , index: index),
        );
      },
    );
  }
}
