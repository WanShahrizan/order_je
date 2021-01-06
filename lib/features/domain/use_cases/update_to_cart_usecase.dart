
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class UpdateToCartCase{
  final FirebaseRepository repository;

  UpdateToCartCase({this.repository});

  Future<void> call(AddToCartEntity addToCartEntity){
    return repository.updateToCart(addToCartEntity);
  }
}