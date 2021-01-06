import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_je/features/presentation/screens/customer_login_page.dart';
import 'package:order_je/features/presentation/screens/stall_owner_login_page.dart';
import 'package:order_je/features/presentation/widgets/common.dart';


class UserTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset('assets/background.png',fit: BoxFit.cover,),),
          Positioned(
            right: 185,
            top: -265,
            child: Container(
              width: 460,
              height: 460,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(300)),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              child: Image.asset('assets/Order Je!.png'),
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Container(
              child: (
              Image.asset('assets/Type of user.png')
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  height: 86,
                  width: 294,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.black)
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 12,bottom: 7),
                        child: Image.asset('assets/kek 1.png'),
                      ),
                      SizedBox(width: 18,),
                      InkWell(
                        onTap: (){
                          push(context, CustomerLoginPage());
                        },
                        child: Container(
                          width: 154,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(color: Colors.black)
                          ),
                          child: Align(child: Text('Customer',textAlign: TextAlign.center,)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 86,
                  width: 294,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.black)
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20,bottom: 7),
                        child: Image.asset('assets/stall.png'),
                      ),
                      SizedBox(width: 30,),
                      InkWell(
                        onTap: (){
                          push(context, StallOwnerLoginPage());
                        },
                        child: Container(
                          width: 154,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              border: Border.all(color: Colors.black)
                          ),
                          child: Align(child: Text('Stall Owner',textAlign: TextAlign.center,)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      )
    );
  }
}
