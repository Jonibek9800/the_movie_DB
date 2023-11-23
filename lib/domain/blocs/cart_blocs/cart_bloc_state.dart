import 'cart_bloc_model.dart';

abstract class CartBlocState {
  CartBlocModel cartBlocModel;

  CartBlocState({required this.cartBlocModel});
}

class InitCartState extends CartBlocState {
  InitCartState({required CartBlocModel cartBlocModel})
      : super(cartBlocModel: cartBlocModel);
}

class AddCartState extends CartBlocState {
  AddCartState({required CartBlocModel cartBlocModel})
      : super(cartBlocModel: cartBlocModel);
}

class RemoveToCartState extends CartBlocState {
  RemoveToCartState({required CartBlocModel cartBlocModel})
      : super(cartBlocModel: cartBlocModel);
}

class ErrorCartState extends CartBlocState {
  ErrorCartState({required CartBlocModel cartBlocModel})
      : super(cartBlocModel: cartBlocModel);
}

class AddQuantityState extends CartBlocState {
  AddQuantityState({required CartBlocModel cartBlocModel})
      : super(cartBlocModel: cartBlocModel);
}

class RemoveQuantityState extends CartBlocState {
  RemoveQuantityState({required CartBlocModel cartBlocModel})
      : super(cartBlocModel: cartBlocModel);
}