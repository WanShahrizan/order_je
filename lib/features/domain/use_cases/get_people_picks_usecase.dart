
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class GetPeoplePickUseCase{
  final FirebaseRepository repository;

  GetPeoplePickUseCase({this.repository});

  Stream<List<AddToCartEntity>> call(){
    return repository.getPeoplePicks();
  }
}