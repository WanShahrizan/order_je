


import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class SignInUseCase{
  final FirebaseRepository repository;

  SignInUseCase({this.repository});


  Future<void> call(String email,String password)async{
    return repository.signIn(email, password);
  }


}