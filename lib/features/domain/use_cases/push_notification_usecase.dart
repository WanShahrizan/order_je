

import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class PushNotificationUseCase{
  final FirebaseRepository repository;

  PushNotificationUseCase({this.repository});

  Future<void> call(){
    return repository.pushNotification();
  }
}