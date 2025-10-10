import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.textfieldName,
    required this.keyboardType,
    required this.controller,
    this.errorText,
  });

  final String textfieldName;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(15), // زوايا دائرية
        ),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.right,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: textfieldName,
            errorText: errorText,
            border: InputBorder.none, // مهم علشان مايبقاش فيه إطارين فوق بعض
          ),
        ),

      ),
    );
  }
}
