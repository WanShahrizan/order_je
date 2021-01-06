


import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class ForgetPasswordUseCase{
  final FirebaseRepository repository;

  ForgetPasswordUseCase({this.repository});


  Future<void> call(String email)async{
    return repository.forgetPassword(email);
  }


}