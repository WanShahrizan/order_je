import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:order_je/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:order_je/features/presentation/cubit/login/login_cubit.dart';
import 'package:order_je/features/presentation/pages/home_page.dart';
import 'package:order_je/features/presentation/screens/initial_main_screen.dart';
import 'package:order_je/features/presentation/widgets/common.dart';
import '';
class CustomerSignUpPage extends StatefulWidget {
  @override
  _CustomerSignUpPageState createState() => _CustomerSignUpPageState();
}

class _CustomerSignUpPageState extends State<CustomerSignUpPage> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _reTypePasswordController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _reTypePasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit,LoginState>(
        builder: (BuildContext context, loginState) {
          if (loginState is LoginLoading){
            return _loadingWidget();
          }
          if (loginState is LoginSuccess){
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  print("authenticsted ${authState.uid}");
                  return InitialMainScreen(uid: authState.uid,);
                } else {
                  print("Unauthenticsted");
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
        }, listener: (BuildContext context, loginState) {
        if (loginState is LoginSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
      },),
    );
  }

  Widget _bodyWidget(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Image.asset('assets/custom_header_image.png'),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Sign Up',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Container(
                  height: 49,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.account_circle)
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Container(
                  height: 49,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.vpn_key)
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Container(
                  height: 49,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  child: TextField(
                    obscureText: true,
                    controller: _reTypePasswordController,
                    decoration: InputDecoration(
                        hintText: 'Re-Type Password',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.vpn_key)
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                    _submitSignUp();
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 108,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        'Create',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _loadingWidget(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/loading.json',),
          SizedBox(height: 30,),
          Text("Setting up your account, Please Wait",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
        ],
      ),
    );
  }

  void _submitSignUp() {
    if (_passwordController.text.isNotEmpty && _emailController.text.isNotEmpty){
      BlocProvider.of<LoginCubit>(context).signUpSubmit(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
    _clear();

  }
  void _clear(){
    _emailController.clear();
    _passwordController.clear();
  }
}
