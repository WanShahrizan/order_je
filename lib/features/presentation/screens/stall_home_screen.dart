import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_je/features/domain/entities/stall_home_screen_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/presentation/pages/alert_order_page.dart';
import 'package:order_je/features/presentation/pages/profile_page.dart';
import 'package:order_je/features/presentation/pages/stall_home_page.dart';
import 'package:order_je/features/presentation/widgets/theme/style.dart';

class StallHomeScreen extends StatefulWidget {
  final UserEntity user;

  const StallHomeScreen({Key key, this.user}) : super(key: key);

  @override
  _StallHomeScreenState createState() => _StallHomeScreenState();
}

class _StallHomeScreenState extends State<StallHomeScreen> {


  int _navPageIndex = 1;

  List<Widget> get _pages =>
      [AlertOrderPage(uid: widget.user.uid,), StallHomePage(user: widget.user,), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_navPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          print(index);
          setState(() {
            _navPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _navPageIndex == 0 ? Image.asset(
              'assets/notification_selected.png', width: 30, height: 30,):Image.asset(
              'assets/notification.png', width: 30, height: 30,),
            backgroundColor: Colors.white,
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: _navPageIndex==1?Image.asset(
              'assets/manu_icon.png', width: 30, height: 30,):Image.asset('assets/manu.png', width: 30, height: 30,),
            backgroundColor: Colors.white,
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: _navPageIndex==2?Image.asset(
              'assets/user_selectyed.png', width: 30, height: 30,):Image.asset('assets/user.png', width: 30, height: 30,),
            backgroundColor: Colors.white,
            title: Text(''),
          ),
        ],
      ),
    );
  }
}