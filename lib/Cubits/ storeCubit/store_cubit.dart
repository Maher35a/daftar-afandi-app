import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../Models/storemodel/StoreModel.dart';
part 'store_state.dart';
class StoreCubit extends Cubit<StoreState> {
  final Box<ProductModel> box;

  StoreCubit(this.box) : super(StoreInitial());

  void loadProducts() {
    final products = box.values.toList();
    emit(StoreLoaded(products));
  }

  void addProduct(ProductModel product) {
    box.add(product);
    loadProducts();
  }

  void updateProduct(int index, ProductModel updated) {
    box.putAt(index, updated);
    loadProducts();
  }

  void deleteProduct(int index) {
    box.deleteAt(index);
    loadProducts();
  }
}
