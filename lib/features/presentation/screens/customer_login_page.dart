import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:order_je/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:order_je/features/presentation/cubit/google_auth/google_auth_cubit.dart';
import 'package:order_je/features/presentation/cubit/login/login_cubit.dart';
import 'package:order_je/features/presentation/pages/customer_signup_page.dart';
import 'package:order_je/features/presentation/screens/forget_password_screen.dart';
import 'package:order_je/features/presentation/widgets/common.dart';
import '';
import 'initial_main_screen.dart';

class CustomerLoginPage extends StatefulWidget {
  @override
  _CustomerLoginPageState createState() => _CustomerLoginPageState();
}

class _CustomerLoginPageState extends State<CustomerLoginPage> {

  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
  Widget _bodyWidget(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Image.asset('assets/custom_header_image.png'),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
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
                        prefixIcon: Icon(Icons.account_circle)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 49,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.vpn_key)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    push(context, ForgetPasswordScreen());
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(color: Colors.amber, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    _submitLogin();
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
                        'Sign In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.3),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.3),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _googleSignIn(),
                      SizedBox(
                        width: 24,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 46,
                        width: 47,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Image.asset(
                          'assets/facebook.png',
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                    onTap: () {
                      push(context, CustomerSignUpPage());
                    },
                    child: Align(
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.amber,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _googleSignIn(){
    return BlocConsumer<GoogleAuthCubit,GoogleAuthState>(
      builder: (BuildContext context, googleState) {
        if (googleState is GoogleAuthLoading){
          return   Container(
            padding: EdgeInsets.all(8),
            height: 46,
            width: 47,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: Colors.black),
            ),
            child: CircularProgressIndicator(backgroundColor: Colors.orange,),
          );
        }


        return  InkWell(
          onTap: (){
            BlocProvider.of<GoogleAuthCubit>(context).googleSignIn();
            },
          child: Container(
            padding: EdgeInsets.all(8),
            height: 46,
            width: 47,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: Colors.black),
            ),
            child: Image.asset("assets/google.png")
          ),
        );
      }, listener: (BuildContext context, googleState) {
      if (googleState is GoogleAuthSuccess) {
        BlocProvider.of<AuthCubit>(context).loggedIn();
        Navigator.pop(context);
      }
    },);
  }

  void _submitLogin() {
    if (_passwordController.text.isNotEmpty && _emailController.text.isNotEmpty){
      BlocProvider.of<LoginCubit>(context).signInInSubmit(
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
