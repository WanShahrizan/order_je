import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_je/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:order_je/features/presentation/cubit/order/order_cubit.dart';
import 'package:order_je/features/presentation/cubit/stall_menu/stall_menu_cubit.dart';
import 'package:order_je/features/presentation/screens/customer_login_page.dart';
import 'package:order_je/features/presentation/screens/initial_main_screen.dart';
import 'package:order_je/features/presentation/screens/user_type_screen.dart';
import 'features/domain/use_cases/push_notification_usecase.dart';
import 'features/presentation/cubit/auth/auth_cubit.dart';
import 'features/presentation/cubit/google_auth/google_auth_cubit.dart';
import 'features/presentation/cubit/login/login_cubit.dart';
import 'features/presentation/cubit/people_pick/people_pick_cubit.dart';
import 'features/presentation/cubit/user/user_cubit.dart';
import 'injection_container.dart' as di;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  di.sl.call<PushNotificationUseCase>().call();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<LoginCubit>(
          create: (_) => di.sl<LoginCubit>(),
        ),
        BlocProvider<GoogleAuthCubit>(
          create: (_) => di.sl<GoogleAuthCubit>(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>(),
        ),
        BlocProvider<StallMenuCubit>(
          create: (_) => di.sl<StallMenuCubit>(),
        ),
        BlocProvider<AddToCartCubit>(
          create: (_) => di.sl<AddToCartCubit>(),
        ),
        BlocProvider<PeoplePickCubit>(
          create: (_) => di.sl<PeoplePickCubit>(),
        ),
        BlocProvider<OrderCubit>(
          create: (_) => di.sl<OrderCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Order Je',
        theme: ThemeData(
           primaryColor: Colors.orange
        ),
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return InitialMainScreen(uid: authState.uid,);
                } else {
                  return UserTypeScreen();
                }
              },
            );
          }
        },
       // home: UserTypeScreen()
      ),
    );

  }
}
