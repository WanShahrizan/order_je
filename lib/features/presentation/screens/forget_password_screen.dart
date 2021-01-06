import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:order_je/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:order_je/features/presentation/cubit/google_auth/google_auth_cubit.dart';
import 'package:order_je/features/presentation/cubit/login/login_cubit.dart';
import 'package:order_je/features/presentation/pages/customer_signup_page.dart';
import 'package:order_je/features/presentation/widgets/common.dart';
import '';
import 'initial_main_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  TextEditingController _emailController=TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
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
                  'Forget Password',
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.account_circle)),
                  ),
                ),
                SizedBox(
                  height: 25,
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
                        'Send',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),

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
    if (_emailController.text.isEmpty){
     toast(message: "Enter your email");
      return;
    }
    BlocProvider.of<LoginCubit>(context).forgetPassword(
      email: _emailController.text,
    );
    toast(message: "Please Check your email");
    _clear();

  }
  void _clear(){
    _emailController.clear();
  }
}
