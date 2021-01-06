import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_je/features/presentation/cubit/auth/auth_cubit.dart';
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            child: Image.asset('assets/custom_header.png'),
          ),
          Positioned(
            top: 50,
            left: 25,
            child: Container(
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
          ),
          // Positioned(
          //   top: 38,
          //   left: 45,
          //   child: Container(
          //     child: Image.asset('assets/profile_img.png'),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(left: 30,right: 30),
            margin: EdgeInsets.only(top: 170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   child: Text('Profile',style: TextStyle(fontSize: 40),),
                // ),
                SizedBox(height: 60,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('My Account',style: TextStyle(fontSize:24,fontWeight: FontWeight.w500),),
                      Container(
                        child: Icon(
                          Icons.arrow_forward_ios
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  height: 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: (){
                    BlocProvider.of<AuthCubit>(context).loggedOut();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Text("Sign Out",style: TextStyle(fontSize:20,fontWeight: FontWeight.w500),),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
