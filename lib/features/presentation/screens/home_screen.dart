import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_je/features/domain/entities/stall_entity.dart';
import 'package:order_je/features/domain/entities/stall_entity_people.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/presentation/pages/cart_page.dart';
import 'package:order_je/features/presentation/pages/home_page.dart';
import 'package:order_je/features/presentation/pages/order_notification.dart';
import 'package:order_je/features/presentation/pages/profile_page.dart';
import 'package:order_je/features/presentation/pages/stall_manu.dart';
import 'package:order_je/features/presentation/widgets/theme/style.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity user;

  const HomeScreen({Key key, this.user}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _data = StallEntity.stallData;

  final _people = StallEntityPeople.stallPeopleData;

  int _navPageIndex=0;

  List<Widget> get _pages => [HomePage(user: widget.user,),StallMenu(uid: null,name: null,userEntity: widget.user,),CartPage(userEntity: widget.user,),OrderNotificationPage(uid: widget.user.uid,),ProfilePage()];
  @override
  void initState() {
    print(widget.user.uid);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body:_pages[_navPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index){
            print(index);
            setState(() {
              _navPageIndex=index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: _navPageIndex==0?Image.asset(
                'assets/home_selected.png',
                width: 30,
                height: 30,
              ):Container(
                child: Image.asset(
                  'assets/home.png',
                  width: 30,
                  height: 30,
                ),
              ),
              backgroundColor: Colors.white,
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: _navPageIndex==1?Image.asset(
                'assets/bascet3_selected.png',
                width: 30,
                height: 30,
              ):Image.asset(
                'assets/bascet3.png',
                width: 30,
                height: 30,
              ),
              backgroundColor: Colors.white,
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: _navPageIndex==2?Image.asset(
                'assets/bascket_selected.png',
                width: 30,
                height: 30,
              ):Image.asset(
                'assets/bascket.png',
                width: 30,
                height: 30,
              ),
              backgroundColor: Colors.white,
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: _navPageIndex==3?Image.asset(
                'assets/notification_selected.png',
                width: 30,
                height: 30,
              ):Image.asset(
                'assets/notification.png',
                width: 30,
                height: 30,
              ),
              backgroundColor: Colors.white,
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: _navPageIndex==4?Image.asset(
                'assets/user_selectyed.png',
                width: 30,
                height: 30,
              ):Image.asset(
                'assets/user.png',
                width: 30,
                height: 30,
              ),
              backgroundColor: Colors.white,
              title: Text(''),
            ),
          ],
        ),
      );
  }
}
