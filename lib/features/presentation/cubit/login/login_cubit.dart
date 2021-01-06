import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/use_cases/forget_password_usecase.dart';
import 'package:order_je/features/domain/use_cases/get_create_current_user.dart';
import 'package:order_je/features/domain/use_cases/google_sign_in_usecase.dart';
import 'package:order_je/features/domain/use_cases/sign_in_usecase.dart';
import 'package:order_je/features/domain/use_cases/sign_up_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;

  LoginCubit(
      {this.signUpUseCase,
      this.signInUseCase,
      this.getCreateCurrentUserUseCase,this.forgetPasswordUseCase})
      : super(LoginInitial());

  Future<void> signInInSubmit({String email, String password}) async {
    emit(LoginLoading());
    try {
      await signInUseCase.call(email, password);
      emit(LoginSuccess());
    } on SocketException catch (_) {
      emit(LoginFailure());
    } catch (_) {
      emit(LoginFailure());
    }
  }
  Future<void> forgetPassword({String email}) async {
    try {
      await forgetPasswordUseCase.call(email);
    } on SocketException catch (_) {
    } catch (_) {
    }
  }

  Future<void> signUpSubmit({String email, String password}) async {
    emit(LoginLoading());
    try {
      await signUpUseCase.call(email, password);
      await getCreateCurrentUserUseCase.call(UserEntity(
        emailAddress: email,
      ));
      emit(LoginSuccess());
    } on SocketException catch (_) {
      emit(LoginFailure());
    } catch (_) {
      emit(LoginFailure());
    }
  }
}
