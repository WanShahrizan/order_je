


import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class GetCrashlyticsUseCase{
  final FirebaseRepository repository;

  GetCrashlyticsUseCase({this.repository});

  Future<void> call()async{
    return repository.getCrashlytics();
  }
}