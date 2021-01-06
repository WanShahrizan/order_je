import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_je/features/domain/use_cases/get_current_uid_usecase.dart';
import 'package:order_je/features/domain/use_cases/is_signin_usecase.dart';
import 'package:order_je/features/domain/use_cases/sign_out_usecase.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignUseCase isSignUseCase;
  final GetCurrentUidUseCase getCurrentUIDUseCase;
  final SignOutUseCase signOutUseCase;
  AuthCubit({this.isSignUseCase,this.getCurrentUIDUseCase,this.signOutUseCase}) : super(AuthInitial());

  Future<void> appStarted()async{
    try{
      bool isSignIn = await isSignUseCase.call();
      if (isSignIn){
        final uid=await getCurrentUIDUseCase.call();
        emit(Authenticated(uid));
      }else
        emit(UnAuthenticated());
    }catch(_){
      emit(UnAuthenticated());
    }
  }
  Future<void> loggedIn()async{
    try{
      final uid=await getCurrentUIDUseCase.call();
      emit(Authenticated(uid));
    }catch(_){}
  }

  Future<void> loggedOut()async{
    await signOutUseCase.call();
    try{
      await signOutUseCase.call();
      emit(UnAuthenticated());
    }catch(_){
      emit(UnAuthenticated());
    }
  }
}
