import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    required this.containerColor,
    required this.containerText,
    required this.containerTextColor,
    this.containerBorderColor,
    required this.screenToOpen,
  });
  final Color containerColor;
  final Color containerTextColor;
  final String containerText;
  final Color? containerBorderColor;
  final Widget screenToOpen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screenToOpen),
          );
        },
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: containerColor,
            border: Border.all(
              color: containerBorderColor ?? Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              containerText,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: containerTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

