import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_je/features/domain/use_cases/google_sign_in_usecase.dart';
part 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final GoogleSignInUseCase googleSignInUseCase;

  GoogleAuthCubit({this.googleSignInUseCase}) : super(GoogleAuthInitial());

  Future<void> googleSignIn() async {
    try {
      await googleSignInUseCase.call();
      emit(GoogleAuthSuccess());
    } on SocketException catch (_) {
      emit(GoogleAuthFailure());
    } catch (_) {
      emit(GoogleAuthFailure());
    }
  }
}
