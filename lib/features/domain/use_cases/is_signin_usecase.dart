


import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class IsSignUseCase{
  final FirebaseRepository repository;

  IsSignUseCase({this.repository});


  Future<bool> call()async{
    return repository.isSignIn();
  }


}