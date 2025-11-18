import 'package:flutter/material.dart';

import '../../costant/Button_Continer.dart';

class PurchasesPage extends StatelessWidget {
  const PurchasesPage({super.key});

  @override
  Widget build(BuildContext context) =>
      const Scaffold(
          body:       Column(
            children: [
              ContainerWidget(
                containerColor:Colors.white70,
                containerText: " دخل اليوم",
                containerTextColor: Colors.black,
                containerBorderColor: Colors.grey,
                screenToOpen:  PurchasesPage(),
              ),
              ContainerWidget(
                containerColor:Colors.white70,
                containerText: " مصروفات",
                containerTextColor: Colors.black,
                containerBorderColor: Colors.grey,
                screenToOpen:  PurchasesPage(),
              ),
              ContainerWidget(
                containerColor:Colors.white70,
                containerText: "دخل إضافي ",
                containerTextColor: Colors.black,
                containerBorderColor: Colors.grey,
                screenToOpen:  PurchasesPage(),
              ),
              ContainerWidget(
                containerColor:Colors.white70,
                containerText: "تقرير يومي ",
                containerTextColor: Colors.black,
                containerBorderColor: Colors.grey,
                screenToOpen:  PurchasesPage(),
              ),


            ],
          ),
      );
}
