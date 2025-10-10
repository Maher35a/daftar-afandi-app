import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Cubits/ storeCubit/store_cubit.dart';
import '../../../../Models/storemodel/StoreModel.dart';
import 'ProductDialog.dart';
class ProductItem extends StatelessWidget {
  final ProductModel product;
  final int index;

  const ProductItem({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text("${product.name} (${product.category})"),
        subtitle: Text("السعر: ${product.price} - الكمية: ${product.quantity}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => ProductDialog(
                    isEdit: true,
                    index: index,
                    product: product,
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<StoreCubit>().deleteProduct(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
