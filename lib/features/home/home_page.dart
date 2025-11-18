import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../costant/constants.dart';
import '../Customers_Merchants/Customers and Merchants.dart';
import '../PeopleList/PeopleSection.dart';
import '../Purchases/PurchasesPage.dart';
import '../Reports/Reportspage.dart';
import '../Salespage/Sales.dart';
import '../add_entry/add_entry_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  final List<Widget> _screens = [
    const ReportsPage(),
    const Customers_Merchants(),
    const PeopleSection(),
    const PurchasesPage(),
    const SalesPage(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kprimarycolor,
      appBar: AppBar(
        title: const Text("دفتر أفندي"),
        centerTitle: true,
        backgroundColor: kprimarycolor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.sp),
            topRight: Radius.circular(25.sp),
          ),
        ),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: kprimarycolor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: "التقارير",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: "العملاء والتجار ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "الرئيسية",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.add_business_outlined),
            label: "المشتريات ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: "المبيعات ",
          ),

        ],
      ),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEntryPage()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('إضافة عميل'),
        backgroundColor: kprimarycolor,
        foregroundColor: Colors.white,
      )
          : null,
    );
  }
}
