





import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class GetCreateCurrentUserUseCase{
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({this.repository});


  Future<void> call(UserEntity userEntity)async{
    return repository.getCreateCurrentUser(userEntity);
  }


}