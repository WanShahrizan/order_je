


import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class PeoplePickUseCase{
  final FirebaseRepository repository;

  PeoplePickUseCase({this.repository});


  Future<void> call(AddToCartEntity addToCartEntity)async{
    return repository.peoplePicks(addToCartEntity);
  }


}