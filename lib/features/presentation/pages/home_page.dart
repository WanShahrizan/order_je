import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/stall_entity.dart';
import 'package:order_je/features/domain/entities/stall_entity_people.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:order_je/features/presentation/cubit/people_pick/people_pick_cubit.dart';
import 'package:order_je/features/presentation/cubit/user/user_cubit.dart';
import 'package:order_je/features/presentation/pages/stall_manu.dart';
import 'package:order_je/features/presentation/widgets/common.dart';
import 'package:order_je/features/presentation/widgets/theme/style.dart';

import '../../../app_const.dart';

class HomePage extends StatefulWidget {
  final UserEntity user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _people = StallEntityPeople.stallPeopleData;
  int _quantityCounter=0;
  @override
  void initState() {
    BlocProvider.of<PeoplePickCubit>(context).getPeoplePicks();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      return SingleChildScrollView(
        child: Stack(
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
              top: 45,
              left: 30,
              child: Container(
                height: 24,
                child: Image.asset('assets/Hi There,.png'),
              ),
            ),
            Positioned(
              top: 75,
              left: 30,
              child: Container(
                height: 24,
                child: Image.asset('assets/Go Ahead Order Je!.png'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 155,left: 10),
                      child: Text(
                        "Stall",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 175,
                    child: BlocBuilder<UserCubit,UserState>(
                      builder: (context,UserState userState){
                        if (userState is UserSuccess){
                          final stallUserList=userState.usersData.where((stallUser) => stallUser.accountType ==STALLOWNER).toList();
                          return ListView.builder(
                            itemCount: stallUserList.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final stallUser=stallUserList[index];
                              return InkWell(
                                onTap: (){
                                  push(context, StallMenu(uid: stallUser.uid,name: stallUser.name,userEntity: widget.user,));
                                },
                                child: Container(
                                    height: 163,
                                    width: 177,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: colorFFE1A4,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(24))),
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 105,
                                          width: MediaQuery.of(context).size.width,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            child: CachedNetworkImage(
                                              imageUrl: stallUser.profileUrl,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => CircularProgressIndicator(),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          stallUser.stallName,
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    )),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('People Picks',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ))),
                  BlocBuilder<PeoplePickCubit,PeoplePickState>(builder: (BuildContext context, PeoplePickState peopleState) {

                    if (peopleState is PeoplePickLoaded){
                      return  Container(
                        padding: EdgeInsets.only(top: 5),
                        height: 174,
                        child: ListView.builder(
                            itemCount: peopleState.peoplePickData.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final peopleData=peopleState.peoplePickData[index];
                              return InkWell(
                                onTap: (){
                                  showAddToCartAlertDialog(context,peopleState.peoplePickData,index);
                                },
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height: 163,
                                      width: 177,
                                      decoration: BoxDecoration(
                                        color: colorFFE1A4,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 4,
                                      child: Container(
                                        height: 90,
                                        width: 90,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          child: CachedNetworkImage(
                                            imageUrl: peopleData.imageUrl,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => CircularProgressIndicator(),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 90,
                                            padding:
                                            EdgeInsets.only(top: 23, left: 22),
                                            child: Text(
                                              peopleData.menuName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      width: 150,
                                      top: 97,
                                      left: 22,
                                      child: Container(
                                        child: Text(
                                          "By \n ${peopleData.sellerName}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 130,
                                      left: 22,
                                      child: Container(
                                        child: Text(
                                          "RM ${peopleData.menuPrice}",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      );
                    }

                    return Container(
                      height: 120,
                      child: Center(
                        child: CircularProgressIndicator(backgroundColor: Colors.orange,),
                      ),
                    );
                  },),

                ],
              ),
            )
          ],
        ),
      );
  }
  showAddToCartAlertDialog(
      BuildContext context, List<AddToCartEntity> stallMenuItems, int index) {
    // set up the button

    Widget buttons = Row(
      children: [
        InkWell(
          onTap: () {
            if (_quantityCounter==0){
              toast(message: "Please Add Quantity min 1");
              return;
            }

            BlocProvider.of<AddToCartCubit>(context).addToCart(addToCartEntity: AddToCartEntity(
                sellerUid: stallMenuItems[index].sellerName,
                quantity: _quantityCounter,
                isOrderPlace: false,
                customerUid: widget.user.uid,
                customerName: widget.user.name,
                time: Timestamp.now(),
                imageUrl: stallMenuItems[index].imageUrl,
                menuDescription: stallMenuItems[index].menuDescription,
                menuName: stallMenuItems[index].menuName,
                menuPrice: stallMenuItems[index].menuPrice,
                cartId: "",
                stallId: stallMenuItems[index].stallId,
                sellerName: stallMenuItems[index].sellerName
            ));
            _quantityCounter=0;
            Future.delayed(Duration(microseconds: 400),(){Navigator.pop(context);});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              "Add to cart",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            _quantityCounter=0;
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              "Done",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add to Cart"),
      scrollable: true,
      content: Container(
          height: 350,
          width: 500,
          color: colorFEB727,
          child: StatefulBuilder(
            builder: (_, setState) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(4),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: CachedNetworkImage(
                            imageUrl: stallMenuItems[index].imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stallMenuItems[index].menuName,
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "price : ${stallMenuItems[index].menuPrice}",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                "Seller : ${stallMenuItems[index].sellerName}",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Quantity",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (_quantityCounter > 0)
                                        setState(() => _quantityCounter -= 1);
                                    },
                                    child: Container(
                                        height: 22,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            border:
                                            Border.all(color: Colors.black)),
                                        child: Icon(
                                          Icons.remove,
                                          size: 18,
                                        )),
                                  ),
                                  Container(
                                    height: 22,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)),
                                    child: Text(
                                      "$_quantityCounter",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() => _quantityCounter += 1);
                                    },
                                    child: Container(
                                        height: 22,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            border:
                                            Border.all(color: Colors.black)),
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                        )),
                                  ),
                                ],
                              ),
                              Text("Total:${num.parse(stallMenuItems[index].menuPrice) * _quantityCounter}")
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              constraints: BoxConstraints(
                                maxHeight: 70,
                              ),
                              child: SingleChildScrollView(
                                child: Text(
                                  stallMenuItems[index].menuDescription,
                                  maxLines: null,
                                  overflow: TextOverflow.fade,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
      actions: [
        buttons,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
