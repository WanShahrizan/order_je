import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:order_je/features/domain/use_cases/add_to_cart_usecase.dart';
import 'package:order_je/features/domain/use_cases/add_to_cart_usecase.dart';
import 'package:order_je/features/domain/use_cases/add_to_order_usecase.dart';
import 'package:order_je/features/domain/use_cases/add_to_order_usecase.dart';
import 'package:order_je/features/domain/use_cases/delete_from_order_usecase.dart';
import 'package:order_je/features/domain/use_cases/delete_from_order_usecase.dart';
import 'package:order_je/features/domain/use_cases/delete_to_cart_usecase.dart';
import 'package:order_je/features/domain/use_cases/delete_to_cart_usecase.dart';
import 'package:order_je/features/domain/use_cases/forget_password_usecase.dart';
import 'package:order_je/features/domain/use_cases/forget_password_usecase.dart';
import 'package:order_je/features/domain/use_cases/get_carts_usecase.dart';
import 'package:order_je/features/domain/use_cases/get_carts_usecase.dart';
import 'package:order_je/features/domain/use_cases/get_create_stall_menu.dart';
import 'package:order_je/features/domain/use_cases/get_create_stall_menu.dart';
import 'package:order_je/features/domain/use_cases/get_delete_stall_menu.dart';
import 'package:order_je/features/domain/use_cases/get_delete_stall_menu.dart';
import 'package:order_je/features/domain/use_cases/get_orders_usecase.dart';
import 'package:order_je/features/domain/use_cases/get_orders_usecase.dart';
import 'package:order_je/features/domain/use_cases/get_people_picks_usecase.dart';
import 'package:order_je/features/domain/use_cases/get_people_picks_usecase.dart';
import 'package:order_je/features/domain/use_cases/get_stall_menu.dart';
import 'package:order_je/features/domain/use_cases/get_stall_menu.dart';
import 'package:order_je/features/domain/use_cases/people_pick_usecase.dart';
import 'package:order_je/features/domain/use_cases/people_pick_usecase.dart';
import 'package:order_je/features/domain/use_cases/update_order_usecase.dart';
import 'package:order_je/features/domain/use_cases/update_order_usecase.dart';
import 'package:order_je/features/domain/use_cases/update_to_cart_usecase.dart';
import 'package:order_je/features/domain/use_cases/update_to_cart_usecase.dart';
import 'package:order_je/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:order_je/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:order_je/features/presentation/cubit/google_auth/google_auth_cubit.dart';
import 'package:order_je/features/presentation/cubit/google_auth/google_auth_cubit.dart';
import 'package:order_je/features/presentation/cubit/login/login_cubit.dart';
import 'package:order_je/features/presentation/cubit/order/order_cubit.dart';
import 'package:order_je/features/presentation/cubit/order/order_cubit.dart';
import 'package:order_je/features/presentation/cubit/people_pick/people_pick_cubit.dart';
import 'package:order_je/features/presentation/cubit/login/login_cubit.dart';
import 'package:order_je/features/presentation/cubit/stall_menu/stall_menu_cubit.dart';
import 'features/data/data_sources/firebase_remote_data_source.dart';
import 'features/data/data_sources/firebase_remote_data_source_impl.dart';
import 'features/data/repositories/firebase_repository_impl.dart';
import 'features/domain/repositories/firebase_repository.dart';
import 'features/domain/use_cases/get_all_users_usecase.dart';
import 'features/domain/use_cases/get_analytics_usecase.dart';
import 'features/domain/use_cases/get_crashlytics_usecase.dart';
import 'features/domain/use_cases/get_create_current_user.dart';
import 'features/domain/use_cases/get_current_uid_usecase.dart';
import 'features/domain/use_cases/get_performance_monitoring_usecase.dart';
import 'features/domain/use_cases/get_update_stall_menu.dart';
import 'features/domain/use_cases/google_sign_in_usecase.dart';
import 'features/domain/use_cases/is_signin_usecase.dart';
import 'features/domain/use_cases/push_notification_usecase.dart';
import 'features/domain/use_cases/sign_in_usecase.dart';
import 'features/domain/use_cases/sign_out_usecase.dart';
import 'features/domain/use_cases/sign_up_usecase.dart';
import 'features/presentation/cubit/auth/auth_cubit.dart';
import 'features/presentation/cubit/user/user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
//Future bloc-cubit
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        isSignUseCase: sl.call(),
        signOutUseCase: sl.call(),
        getCurrentUIDUseCase: sl.call(),
      ));
  sl.registerFactory<LoginCubit>(() => LoginCubit(
        getCreateCurrentUserUseCase: sl.call(),
        signInUseCase: sl.call(),
        signUpUseCase: sl.call(),
    forgetPasswordUseCase: sl.call(),
      ));
  sl.registerFactory<GoogleAuthCubit>(() => GoogleAuthCubit(
        googleSignInUseCase: sl.call(),
      ));
  sl.registerFactory<UserCubit>(() => UserCubit(
        getAllUsersUseCase: sl.call(),
        getCreateStallMenuUseCase: sl.call(),
        getUpdateStallMenuUseCase: sl.call(),
        getDeleteStallMenuUseCase: sl.call(),
      ));
  sl.registerFactory<StallMenuCubit>(() => StallMenuCubit(
        getStallMenuUseCase: sl.call(),
      ));
  sl.registerFactory<AddToCartCubit>(() => AddToCartCubit(
        addToCartCase: sl.call(),
        deleteToCartCase: sl.call(),
        getCartCase: sl.call(),
        updateToCartCase: sl.call(),
      ));sl.registerFactory<PeoplePickCubit>(() => PeoplePickCubit(
        getPeoplePickUseCase: sl.call(),
        peoplePickUseCase: sl.call(),
      ));

  sl.registerFactory<OrderCubit>(() => OrderCubit(
   addToOrderCase: sl.call(),
    deleteFromOrderCase: sl.call(),
    getOrderUseCase: sl.call(),
    updateOrderUseCase: sl.call(),
  ));


  //UseCases
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<GoogleSignInUseCase>(
      () => GoogleSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignUseCase>(
      () => IsSignUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<ForgetPasswordUseCase>(
          () => ForgetPasswordUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAnalyticsUseCase>(
      () => GetAnalyticsUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCrashlyticsUseCase>(
      () => GetCrashlyticsUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetPerformanceMonitoringUseCase>(
      () => GetPerformanceMonitoringUseCase(repository: sl.call()));
  sl.registerLazySingleton<PushNotificationUseCase>(
      () => PushNotificationUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateStallMenuUseCase>(
      () => GetCreateStallMenuUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetStallMenuUseCase>(
      () => GetStallMenuUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUpdateStallMenuUseCase>(
      () => GetUpdateStallMenuUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetDeleteStallMenuUseCase>(
      () => GetDeleteStallMenuUseCase(repository: sl.call()));

  sl.registerLazySingleton<AddToCartCase>(
      () => AddToCartCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteToCartCase>(
      () => DeleteToCartCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateToCartCase>(
      () => UpdateToCartCase(repository: sl.call()));
  sl.registerLazySingleton<GetCartCase>(
      () => GetCartCase(repository: sl.call()));

  sl.registerLazySingleton<GetPeoplePickUseCase>(
          () => GetPeoplePickUseCase(repository: sl.call()));
  sl.registerLazySingleton<PeoplePickUseCase>(
          () => PeoplePickUseCase(repository: sl.call()));

  sl.registerLazySingleton<AddToOrderCase>(
          () => AddToOrderCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteFromOrderCase>(
          () => DeleteFromOrderCase(repository: sl.call()));
  sl.registerLazySingleton<GetOrderUseCase>(
          () => GetOrderUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateOrderUseCase>(
          () => UpdateOrderUseCase(repository: sl.call()));


  //Repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  //Remote DataSource
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpl(
            auth: sl.call(),
            firestore: sl.call(),
            analytics: sl.call(),
            fcm: sl.call(),
            googleSignInAuth: sl.call(),
          ));

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final googleSignInAuth = GoogleSignIn();
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  final FirebaseMessaging fcm = FirebaseMessaging();

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => googleSignInAuth);
  sl.registerLazySingleton(() => analytics);
  sl.registerLazySingleton(() => fcm);
}
