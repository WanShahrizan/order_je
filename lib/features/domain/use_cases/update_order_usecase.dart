
import 'package:order_je/features/domain/entities/order_entity.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class UpdateOrderUseCase{
  final FirebaseRepository repository;

  UpdateOrderUseCase({this.repository});

  Future<void> call(OrderEntity orderEntity){
    return repository.updateOrder(orderEntity);
  }
}