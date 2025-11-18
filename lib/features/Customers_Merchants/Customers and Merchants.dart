import 'package:daftar_afandi_app/features/Purchases/PurchasesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../costant/Button_Continer.dart';

class Customers_Merchants extends StatelessWidget {
  const Customers_Merchants({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(    body:      Padding(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        children: [

          ContainerWidget(
            containerColor:Colors.white70,
            containerText: " فاتوره",
            containerTextColor: Colors.black,
            containerBorderColor: Colors.grey,
            screenToOpen:  PurchasesPage(),
          ),
          ContainerWidget(
            containerColor:Colors.white70,
            containerText: "  إضافة منتج ",
            containerTextColor: Colors.black,
            containerBorderColor: Colors.grey,
            screenToOpen:  PurchasesPage(),
          ),
          ContainerWidget(
            containerColor:Colors.white70,
            containerText: "تجديد السعر",
            containerTextColor: Colors.black,
            containerBorderColor: Colors.grey,
            screenToOpen:  PurchasesPage(),
          ),


        ],
      ),
    ),
    );


  }
}
