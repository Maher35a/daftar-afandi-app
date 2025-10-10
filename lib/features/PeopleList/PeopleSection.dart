import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Cubits/person__cubit.dart';
import '../../costant/Headercard.dart';
import '../../costant/search-widget.dart';
import '../PeopleList/PersonList-page.dart';

class PeopleSection extends StatelessWidget {
  const PeopleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonCubit, PersonState>(
      builder: (context, state) {
        if (state is PersonInitial) {
          context.read<PersonCubit>().loadPeople();
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PersonLoaded) {
          final people = state.filteredPeople;
          final allPeople = state.people;

          if (allPeople.isEmpty) {
            return Center(
              child: Text(
                "لا يوجد عملاء بعد",
                style: TextStyle(fontSize: 32.sp),
              ),
            );
          }
          if (people.isEmpty) {
            return Column(
              children: [
                const SearchField(),
                HeaderCard(
                  total: allPeople.fold<double>(0, (s, p) => s + p.amount),
                  count: allPeople.length,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "لا توجد نتائج مطابقة",
                      style: TextStyle(fontSize: 20.sp, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            );
          }
          final total = people.fold<double>(0, (s, p) => s + p.amount);
          return Column(
            children: [
              const SearchField(),
              HeaderCard(total: total, count: people.length),
              Expanded(child: PersonList(people: people)),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
