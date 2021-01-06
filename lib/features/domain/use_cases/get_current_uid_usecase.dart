




import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class GetCurrentUidUseCase{
  final FirebaseRepository repository;

  GetCurrentUidUseCase({this.repository});


  Future<String> call()async{
    return repository.getCurrentUid();
  }


}