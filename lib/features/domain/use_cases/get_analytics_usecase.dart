



import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class GetAnalyticsUseCase{
  final FirebaseRepository repository;

  GetAnalyticsUseCase({this.repository});

  Future<void> call(String uid)async{
    return repository.getAnalytics(uid);
  }
}