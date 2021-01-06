


import 'package:order_je/features/domain/repositories/firebase_repository.dart';

class GetPerformanceMonitoringUseCase{
  final FirebaseRepository repository;

  GetPerformanceMonitoringUseCase({this.repository});

  Future<void> call()async{
    return repository.getPerformanceMonitoring();
  }
}