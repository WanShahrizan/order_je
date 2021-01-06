
import 'package:order_je/features/domain/entities/order_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class GetOrderUseCase{
  final FirebaseRepository repository;

  GetOrderUseCase({this.repository});

  Stream<List<OrderEntity>> call(String uid){
    return repository.getOrders(uid);
  }
}