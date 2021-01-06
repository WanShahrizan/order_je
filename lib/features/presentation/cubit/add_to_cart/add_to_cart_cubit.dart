import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/use_cases/add_to_cart_usecase.dart';
import 'package:order_je/features/domain/use_cases/delete_to_cart_usecase.dart';
import 'package:order_je/features/domain/use_cases/get_carts_usecase.dart';
import 'package:order_je/features/domain/use_cases/update_to_cart_usecase.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final GetCartCase getCartCase;
  final AddToCartCase addToCartCase;
  final UpdateToCartCase updateToCartCase;
  final DeleteToCartCase deleteToCartCase;
  AddToCartCubit({this.updateToCartCase,this.deleteToCartCase,this.addToCartCase,this.getCartCase}) : super(AddToCartInitial());



  Future<void> updateToCart({AddToCartEntity addToCartEntity})async{
    try{
      await  updateToCartCase.call(addToCartEntity);
    }on SocketException catch(_){
      emit(AddToCartFailure());
    }
  }

  Future<void> addToCart({AddToCartEntity addToCartEntity})async{
    try{
      await  addToCartCase.call(addToCartEntity);
    }on SocketException catch(_){
      emit(AddToCartFailure());
    }
  }

  Future<void> deleteToCart({String cartId,String uid})async{
    try{
      await  deleteToCartCase.call(cartId,uid);
    }on SocketException catch(_){
      emit(AddToCartFailure());
    }
  }
  Future<void> getCarts({String uid})async{
    try {
      final streamResponse = getCartCase.call(uid);
      streamResponse.listen((response) {
        emit(AddToCartLoaded(addToCartData: response));
      });
    } on SocketException catch (_) {
      emit(AddToCartFailure());
    }
  }


}
