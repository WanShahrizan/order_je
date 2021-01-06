import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/use_cases/get_stall_menu.dart';

part 'stall_menu_state.dart';

class StallMenuCubit extends Cubit<StallMenuState> {
  final GetStallMenuUseCase getStallMenuUseCase;

  StallMenuCubit({this.getStallMenuUseCase}) : super(StallMenuInitial());




  Future<void> getStallMenu() async {
    try {
      final streamResponse = getStallMenuUseCase.call();
      streamResponse.listen((response) {
        emit(UserStallMenuLoaded(stallMenuData: response));
      });
    } on SocketException catch (_) {
      emit(UserStallMenuFailure());
    }
  }
}
