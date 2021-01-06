


import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class SignOutUseCase{
  final FirebaseRepository repository;

  SignOutUseCase({this.repository});


  Future<void> call()async{
    return repository.signOut();
  }


}