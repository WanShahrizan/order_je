import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/use_cases/get_all_users_usecase.dart';
import 'package:order_je/features/domain/use_cases/get_create_stall_menu.dart';
import 'package:order_je/features/domain/use_cases/get_delete_stall_menu.dart';
import 'package:order_je/features/domain/use_cases/get_stall_menu.dart';
import 'package:order_je/features/domain/use_cases/get_update_stall_menu.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetCreateStallMenuUseCase getCreateStallMenuUseCase;
  final GetUpdateStallMenuUseCase getUpdateStallMenuUseCase;
  final GetDeleteStallMenuUseCase getDeleteStallMenuUseCase;
  UserCubit({this.getAllUsersUseCase,this.getCreateStallMenuUseCase,this.getUpdateStallMenuUseCase,this.getDeleteStallMenuUseCase}) : super(UserInitial());

  Future<void> getAllUsers()async{
    try{
    final streamResponse= getAllUsersUseCase.call();
      streamResponse.listen((response) {
        emit(UserSuccess(usersData: response));
      });
    }on SocketException catch(_){
      emit(UserFailure());
    }
  }
  Future<void> getCreateStallMenu({StallMenuEntity stallMenuEntity})async{
    try{
    await  getCreateStallMenuUseCase.call(stallMenuEntity);
    }on SocketException catch(_){
      emit(UserFailure());
    }
  }
  Future<void> getUpdateStallMenu({StallMenuEntity stallMenuEntity})async{
    try{
      await  getUpdateStallMenuUseCase.call(stallMenuEntity);
    }on SocketException catch(_){
      emit(UserFailure());
    }
  }

  Future<void> getDeleteStallMenu({String stallMenuId})async{
    try{
      await  getDeleteStallMenuUseCase.call(stallMenuId);
    }on SocketException catch(_){
      emit(UserFailure());
    }
  }
}
