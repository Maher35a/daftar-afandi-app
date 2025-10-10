import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daftar_afandi_app/costant/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Cubits/ storeCubit/store_cubit.dart';
import 'Store-Widgets/ProductDialog.dart';
import 'Store-Widgets/ProductItem.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kprimarycolor,
      appBar: AppBar(
        title: const Text("المخزن"),
        centerTitle: true,
        backgroundColor: kprimarycolor,
      ),
      body: Container(
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.sp),
            topRight: Radius.circular(25.sp),
          ),
        ),
        child: BlocBuilder<StoreCubit, StoreState>(
          builder: (context, state) {
            if (state is StoreInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StoreLoaded) {
              final products = state.products;

              if (products.isEmpty) {
                return const Center(child: Text("لا يوجد أصناف بالمخزن"));
              }

              return ListView.builder(
                itemCount: products.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductItem(product: product, index: index);
                },
              );
            } else {
              return const Center(child: Text("حصل خطأ ما"));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => ProductDialog());
        },
        backgroundColor: kprimarycolor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
