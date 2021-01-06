import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:order_je/app_const.dart';
import 'package:order_je/features/data/models/user_model.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/presentation/cubit/user/user_cubit.dart';
import 'package:order_je/features/presentation/pages/home_page.dart';
import 'package:order_je/features/presentation/pages/stall_home_page.dart';
import 'package:order_je/features/presentation/screens/home_screen.dart';
import 'package:order_je/features/presentation/screens/stall_home_screen.dart';

class InitialMainScreen extends StatefulWidget {
  final String uid;

  const InitialMainScreen({Key key, this.uid}) : super(key: key);

  @override
  _InitialMainScreenState createState() => _InitialMainScreenState();
}

class _InitialMainScreenState extends State<InitialMainScreen> {

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getAllUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (BuildContext context, UserState state) {
          if (state is UserSuccess){
            final user=state.usersData.firstWhere((user) => user.uid == widget.uid,orElse: () => UserModel());

            if (user.accountType == CUSTOMER){
              return HomeScreen(user: user,);
            }else{
              return StallHomeScreen(user: user,);
            }
          }
          return _loadingWidget();
        },
      ),
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Setting up your account, Please Wait",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 30,
          ),
          SpinKitFadingCube(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
