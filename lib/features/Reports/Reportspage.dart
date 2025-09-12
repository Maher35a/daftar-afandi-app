import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_ReportItem> items = [
      _ReportItem(
        title: "المخزن",
        icon: Icons.store_rounded,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const StorePage()),
          );
        },
      ),
      _ReportItem(
        title: "المبيعات",
        icon: Icons.attach_money_rounded,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SalesPage()),
          );
        },
      ),
      _ReportItem(
        title: "المشتريات",
        icon: Icons.shopping_cart_rounded,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PurchasesPage()),
          );
        },
      ),

    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: item.onTap,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(item.icon, size: 32, color: Colors.blue),
                  const SizedBox(width: 16),
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// كلاس صغير لتنظيم العناصر
class _ReportItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  _ReportItem({required this.title, required this.icon, required this.onTap});
}

// صفحات مؤقتة للتجربة
class SalesPage extends StatelessWidget {
  const SalesPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: Text("صفحة المبيعات")),
  );
}

class PurchasesPage extends StatelessWidget {
  const PurchasesPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: Text("صفحة المشتريات")),
  );
}

class StorePage extends StatelessWidget {
  const StorePage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: Text("صفحة المخزن")),
  );
}
