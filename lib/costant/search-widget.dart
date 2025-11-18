import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Cubits/person__cubit.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey,width: 1.5.sp),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: "ابحث عن عميل",
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          textAlign: TextAlign.center,
          onChanged: (value) {
            context.read<PersonCubit>().search(value);
          },
        ),
      ),
    );
  }
}
