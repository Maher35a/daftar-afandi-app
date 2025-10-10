import 'package:flutter/material.dart';

import 'constants.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key, required this.total,  this.count=1});

  final double total;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final primary = kprimarycolor;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 4),
              color: Color(0x1A000000),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.account_balance_wallet, color: primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("إجمالي المبالغ",
                      style: TextStyle(fontSize: 14, color: Colors.black54)),
                  Text(
                    "${total.toStringAsFixed(2)} ج.م",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "العملاء: $count",
                style: TextStyle(
                    color: primary, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
