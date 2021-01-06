part of 'add_to_cart_cubit.dart';

abstract class AddToCartState extends Equatable {
  const AddToCartState();
}

class AddToCartInitial extends AddToCartState {
  @override
  List<Object> get props => [];
}

class AddToCartLoading extends AddToCartState {
  @override
  List<Object> get props => [];
}

class AddToCartLoaded extends AddToCartState {
  final List<AddToCartEntity> addToCartData;

  AddToCartLoaded({this.addToCartData});
  @override
  List<Object> get props => [this.addToCartData];
}

class AddToCartFailure extends AddToCartState {
  @override
  List<Object> get props => [];
}