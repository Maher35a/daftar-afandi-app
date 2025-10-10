import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Cubits/person__cubit.dart';
import '../../costant/Adding_Button.dart';
import '../../costant/constants.dart';
import '../../costant/text_fild_widget.dart';
import '../../costant/imagepicker.dart';
class AddEntryPage extends StatefulWidget {
  const AddEntryPage({super.key});
  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final imageController = TextEditingController();
  final noteController = TextEditingController();
  String? nameError;
  String? amountError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kprimarycolor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(25.sp),
            topRight: Radius.circular(25.sp),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImagePickerAvatar(
                imagePath: null,
                onImageSelected: (path) {
                  imageController.text = path;
                },
              ),
               SizedBox(height: 20.h),
               SizedBox(height: 20.h),
              TextFieldWidget(
                textfieldName: 'الاسم',
                keyboardType: TextInputType.text,
                controller: nameController,
                errorText: nameError,
              ),
              SizedBox(height: 10.h),
              TextFieldWidget(
                textfieldName: 'المبلغ',
                keyboardType: TextInputType.number,
                controller: amountController,
                errorText: amountError,
              ),
              SizedBox(height: 10.h),

               SizedBox(height: 20.h),
              ActionButton(
                nameController: nameController,
                amountController: amountController,
                imageController: imageController,
                label: "إضافة عميل",
                onValidation: ({String? nameError, String? amountError}) {
                  setState(() {
                    this.nameError = nameError;
                    this.amountError = amountError;
                  });
                },
                onSubmit: (person) {
                  context.read<PersonCubit>().addPerson(person);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: const Text(
                          "تمت العملية بنجاح",
                          textAlign: TextAlign.center,
                        ),
                        content: const Text(
                          "تمت إضافة العميل إلى دفتر أفندي.",
                          textAlign: TextAlign.center,

                        ),
                      );
                    },
                  );
                  Navigator.of(context).pop();
                  nameController.clear();
                  amountController.clear();
                  imageController.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
