import 'package:flutter/material.dart';
import '../../Cubits/updatePerson-cubit/update_person_cubit.dart';

class AmountButtons extends StatelessWidget {
  final TextEditingController amountController;
  final TextEditingController noteController;
  final UpdatePersonCubit cubit;
  final Function(String? error) onError;
  final Function(double value, String note) onConfirm;
  const AmountButtons({
    super.key,
    required this.amountController,
    required this.noteController,
    required this.cubit,
    required this.onError,
    required this.onConfirm, // ✅ لازم هنا كمان
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // لون اخضر
            foregroundColor: Colors.white, // لون النص
          ),
          onPressed: () {
            final text = amountController.text.trim();

            if (text.isEmpty) {
              onError("ادخل المبلغ");
              return;
            }

            final value = double.tryParse(text);
            if (value == null) {
              onError("مبلغ غير صالح");
              return;
            }

            onError(null);

            final note = noteController.text
                .trim()
                .isEmpty
                ? "إضافة"
                : noteController.text.trim();

            onConfirm(value, note);
          },
          child: const Text("إضافة"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // لون احمر
            foregroundColor: Colors.white, // لون النص
          ),
          onPressed: () {
            final text = amountController.text.trim();

            if (text.isEmpty) {
              onError("ادخل المبلغ");
              return;
            }

            final value = double.tryParse(text);
            if (value == null) {
              onError("مبلغ غير صالح");
              return;
            }

            onError(null);
            final note = noteController.text
                .trim()
                .isEmpty
                ? "خصم"
                : noteController.text.trim();
            onConfirm(-value, note);
            amountController.clear();
            noteController.clear();
          },
          child: const Text("خصم"),
        ),
      ],
    );
  }
}
