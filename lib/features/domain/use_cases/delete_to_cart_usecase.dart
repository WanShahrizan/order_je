
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class DeleteToCartCase{
  final FirebaseRepository repository;

  DeleteToCartCase({this.repository});

  Future<void> call(String cartId,String uid){
    return repository.deleteToCart(cartId,uid);
  }
}