import 'package:flutter/material.dart';
final kprimarycolor = Color(0xFF326CE9);
class ThreeColorBackground extends StatelessWidget {
  final Widget? child; // لو عايز تحط أي حاجة فوق الخلفية

  const ThreeColorBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E88E5), // أزرق
            Color(0xFF8D6E63), // بني
            Color(0xFFDC143C), // احمر
          ],
        ),
      ),
      child: child,
    );
  }
}
