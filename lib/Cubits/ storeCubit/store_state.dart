part of 'store_cubit.dart';

abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoaded extends StoreState {
  final List<ProductModel> products;
  StoreLoaded(this.products);
}
