
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class GetDeleteStallMenuUseCase{
  final FirebaseRepository repository;

  GetDeleteStallMenuUseCase({this.repository});

  Future<void> call(String stallMenuId){
    return repository.getDeleteStallMenu(stallMenuId);
  }
}