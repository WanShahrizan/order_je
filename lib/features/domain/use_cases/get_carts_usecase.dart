
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class GetCartCase{
  final FirebaseRepository repository;

  GetCartCase({this.repository});

  Stream<List<AddToCartEntity>> call(String uid){
    return repository.getCarts(uid);
  }
}