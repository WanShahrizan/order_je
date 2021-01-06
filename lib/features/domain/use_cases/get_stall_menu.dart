
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class GetStallMenuUseCase{
  final FirebaseRepository repository;

  GetStallMenuUseCase({this.repository});

  Stream<List<StallMenuEntity>> call(){
    return repository.getStallMenu();
  }
}