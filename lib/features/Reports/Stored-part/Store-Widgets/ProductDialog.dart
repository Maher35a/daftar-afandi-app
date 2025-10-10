import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Cubits/ storeCubit/store_cubit.dart';
import '../../../../Models/storemodel/StoreModel.dart';

class ProductDialog extends StatelessWidget {
  final bool isEdit;
  final int? index;
  final ProductModel? product;

  ProductDialog({super.key, this.isEdit = false, this.index, this.product});

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Pre-fill if edit
    if (product != null) {
      categoryController.text = product!.category;
      nameController.text = product!.name;
      priceController.text = product!.price.toString();
      quantityController.text = product!.quantity.toString();
    }

    return AlertDialog(
      title: Text(isEdit ? "تعديل صنف" : "إضافة صنف جديد"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "النوع"),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "اسم الصنف"),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "السعر"),
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "الكمية"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("إلغاء"),
        ),
        ElevatedButton(
          onPressed: () {
            final productModel = ProductModel(
              category: categoryController.text,
              name: nameController.text,
              price: double.tryParse(priceController.text) ?? 0,
              quantity: int.tryParse(quantityController.text) ?? 0,
            );

            if (isEdit && index != null) {
              context.read<StoreCubit>().updateProduct(index!, productModel);
            } else {
              context.read<StoreCubit>().addProduct(productModel);
            }

            Navigator.pop(context);
          },
          child: Text(isEdit ? "تحديث" : "إضافة"),
        ),
      ],
    );
  }
}
