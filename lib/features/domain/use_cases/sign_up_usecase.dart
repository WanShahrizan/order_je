


import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class SignUpUseCase{
  final FirebaseRepository repository;

  SignUpUseCase({this.repository});


  Future<void> call(String email,String password)async{
    return repository.signUp(email, password);
  }


}