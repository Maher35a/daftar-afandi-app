import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // ✅ لإرسال البيانات إلى Firebase
import '../Models/personClass.dart';
import 'Button-Validators.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.nameController,
    required this.amountController,
    required this.imageController,
    required this.onValidation,
    required this.onSubmit,
    required this.label,
  });

  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController imageController;

  final void Function({String? nameError, String? amountError}) onValidation;
  final void Function(Person person) onSubmit;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      child: Text(label),
    );
  }

  /// ✅ عند الضغط على الزر
  void _onPressed() async {
    // 🔹 التحقق من صحة البيانات
    final nameError = Validators.validateName(nameController.text);
    final amountError = Validators.validateAmount(amountController.text);

    if (nameError != null || amountError != null) {
      onValidation(nameError: nameError, amountError: amountError);
      return;
    }

    final amount = double.tryParse(amountController.text);
    if (amount == null) {
      onValidation(amountError: "الرجاء إدخال مبلغ صحيح");
      return;
    }

    final person = Person(
      name: nameController.text.trim(),
      amount: amount,
      imagePath: imageController.text.isNotEmpty
          ? imageController.text
          : null,
    );

    onSubmit(person);

    try {
      await _uploadPersonToFirebase(person);
      debugPrint('✅ تم رفع البيانات إلى Firebase بنجاح');
    } catch (e) {
      debugPrint('❌ فشل رفع البيانات إلى Firebase: $e');
    }

    // 🧹 تنظيف الحقول
    _clearFields();
    onValidation(nameError: null, amountError: null);
  }

  /// 📤 رفع بيانات الشخص إلى Firebase Firestore
  Future<void> _uploadPersonToFirebase(Person person) async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('people').doc(person.name).set({
      'name': person.name,
      'amount': person.amount,
      'imagePath': person.imagePath,
      'transactions': person.transactions,
      'createdAt': FieldValue.serverTimestamp(), // وقت الإضافة
    });
  }

  /// 🧹 تنظيف حقول الإدخال
  void _clearFields() {
    nameController.clear();
    amountController.clear();
    imageController.clear();
  }
}
