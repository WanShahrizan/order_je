
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class GetUpdateStallMenuUseCase{
  final FirebaseRepository repository;

  GetUpdateStallMenuUseCase({this.repository});

  Future<void> call(StallMenuEntity stallMenuEntity){
    return repository.getUpdateStallMenu(stallMenuEntity);
  }
}