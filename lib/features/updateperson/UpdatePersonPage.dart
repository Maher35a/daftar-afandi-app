import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Cubits/person__cubit.dart';
import '../../Cubits/updatePerson-cubit/update_person_cubit.dart';
import '../../Models/personClass.dart';
import '../../costant/Headercard.dart';
import '../../costant/constants.dart';
import '../../costant/imagepicker.dart';
import '../../costant/text_fild_widget.dart';
import 'AmountButtons.dart';

class UpdatePersonPage extends StatefulWidget {
  final Person person;
  final int index;

  const UpdatePersonPage({
    super.key,
    required this.person,
    required this.index,
  });
  @override
  State<UpdatePersonPage> createState() => _UpdatePersonPageState();
}
class _UpdatePersonPageState extends State<UpdatePersonPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? _amountError;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdatePersonCubit(
        person: widget.person,
        index: widget.index,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kprimarycolor,
        appBar: AppBar(
          backgroundColor: kprimarycolor,
          title: Center(
            child: Text("اسم العميل : ${widget.person.name}"),
          ),
        ),
        body: BlocBuilder<UpdatePersonCubit, UpdatePersonState>(
          builder: (context, state) {
            final cubit = context.read<UpdatePersonCubit>();
            final person = cubit.person;

            return Container(
              width: double.infinity,
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.sp),
                  topRight: Radius.circular(25.sp),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImagePickerAvatar(
                    imagePath: person.imagePath,
                    onImageSelected: (path) {
                      person.imagePath = path;
                      cubit.saveChanges();
                      context.read<PersonCubit>().loadPeople();
                    },
                  ),
                  const SizedBox(height: 16),
                  HeaderCard(total: person.amount),
                  const SizedBox(height: 16),
                  TextFieldWidget(
                    textfieldName: "المبلغ",
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    errorText: _amountError,
                  ),
                  const SizedBox(height: 12),
                  TextFieldWidget(
                    textfieldName: "(اختياري) ملاحظة",
                    keyboardType: TextInputType.text,
                    controller: _noteController,
                  ),
                  const SizedBox(height: 16),
                  AmountButtons(
                    amountController: _amountController,
                    noteController: _noteController,
                    cubit: cubit,
                    onError: (err) {
                      setState(() => _amountError = err);
                    },
                    onConfirm: (value, note) {
                      final personCubit = context.read<PersonCubit>();
                      cubit.updateAmount(value, note, personCubit);
                      _amountController.clear();
                      _noteController.clear();
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "المعاملات السابقة:",
                    style: TextStyle(fontSize: 20),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: person.transactions.isEmpty
                        ? const Center(
                      child: Text(
                        "لا توجد معاملات بعد",
                        style: TextStyle(fontSize: 20),
                        textDirection: TextDirection.rtl,
                      ),
                    )
                        : ListView.builder(
                      itemCount: person.transactions.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            person.transactions[index],
                            textDirection: TextDirection.rtl,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
