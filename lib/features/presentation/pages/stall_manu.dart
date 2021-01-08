import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/use_cases/get_stall_menu.dart';
import 'package:order_je/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:order_je/features/presentation/cubit/people_pick/people_pick_cubit.dart';
import 'package:order_je/features/presentation/cubit/stall_menu/stall_menu_cubit.dart';
import 'package:order_je/features/presentation/cubit/user/user_cubit.dart';
import 'package:order_je/features/presentation/widgets/common.dart';
import 'package:order_je/features/presentation/widgets/theme/style.dart';

class StallMenu extends StatefulWidget {
  final UserEntity userEntity;
  final String uid;
  final String name;

  const StallMenu({Key key,this.userEntity, this.uid, this.name}) : super(key: key);

  @override
  _StallMenuState createState() => _StallMenuState();
}

class _StallMenuState extends State<StallMenu> {
  int _quantityCounter = 0;

  @override
  void initState() {
    print(widget.userEntity.uid);
    BlocProvider.of<StallMenuCubit>(context).getStallMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset('assets/custom_header.png'),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                child: Text(
                  'Discovery Menu',
                  style: TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 150),
              child: BlocBuilder<StallMenuCubit, StallMenuState>(
                builder: (BuildContext context, StallMenuState state) {
                  if (state is UserStallMenuLoaded) {
                    final stallMenuItems = state.stallMenuData
                        .where((userItems) => userItems.uid == widget.uid)
                        .toList();
                    if (widget.uid != null)
                      return MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: stallMenuItems.isEmpty
                            ? Center(
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.fastfood_outlined,
                                        size: 98,
                                        color: Colors.black.withOpacity(.3),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "No Item Found",
                                        style: TextStyle(
                                            fontSize: 28,
                                            color:
                                                Colors.black.withOpacity(.3)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: stallMenuItems.length,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      showAddToCartAlertDialog(
                                          context, stallMenuItems, index);
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.all(22),
                                          height: 170,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: colorFEB727,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                        ),
                                        Positioned(
                                          top: 22,
                                          left: 23,
                                          right: 23,
                                          child: Container(
                                            height: 125,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: CachedNetworkImage(
                                                imageUrl: stallMenuItems[index]
                                                    .imageUrl,
                                                fit: BoxFit.fitWidth,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 122,
                                          left: 30.5,
                                          child: Container(
                                            height: 15,
                                            width: 58,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Text(
                                             "${stallMenuItems[index].menuPrice}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 152,
                                          left: 34,
                                          child: Container(
                                            child: Text(
                                              stallMenuItems[index].menuName,
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 152,
                                          right: 50,
                                          child: Container(
                                            child: Text(
                                              "Best Saller:\n${widget.name}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                      );
                    else
                      return MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: state.stallMenuData.isEmpty
                            ? Center(
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.fastfood_outlined,
                                        size: 98,
                                        color: Colors.black.withOpacity(.3),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "No Item Found",
                                        style: TextStyle(
                                            fontSize: 28,
                                            color:
                                                Colors.black.withOpacity(.3)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: state.stallMenuData.length,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final stallMenuAll =
                                      state.stallMenuData[index];
                                  return InkWell(
                                    onTap: () {
                                      showAddToCartAlertDialog(
                                          context, state.stallMenuData, index);
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.all(22),
                                          height: 170,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: colorFEB727,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                        ),
                                        Positioned(
                                          top: 22,
                                          left: 23,
                                          right: 23,
                                          child: Container(
                                            height: 125,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: CachedNetworkImage(
                                                imageUrl: stallMenuAll.imageUrl,
                                                fit: BoxFit.fitWidth,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 122,
                                          left: 30.5,
                                          child: Container(
                                            height: 15,
                                            width: 58,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Text(
                                              stallMenuAll.menuPrice,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 152,
                                          left: 34,
                                          child: Container(
                                            child: Text(
                                              stallMenuAll.menuName,
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 152,
                                          right: 50,
                                          child: Container(
                                            child: Text(
                                              "Best Seller:\n${stallMenuAll.sellerName}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                      );
                  }
                  return Center(
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fastfood_outlined,
                            size: 98,
                            color: Colors.black.withOpacity(.3),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No Item Found",
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.black.withOpacity(.3)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAddToCartAlertDialog(
      BuildContext context, List<StallMenuEntity> stallMenuItems, int index) {
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
              sellerUid: stallMenuItems[index].uid,
              quantity: _quantityCounter,
              isOrderPlace: false,
              customerUid: widget.userEntity.uid,
              customerName: widget.userEntity.name,
              time: Timestamp.now(),
              imageUrl: stallMenuItems[index].imageUrl,
              menuDescription: stallMenuItems[index].menuDescription,
              menuName: stallMenuItems[index].menuName,
              menuPrice: stallMenuItems[index].menuPrice,
              cartId: "",
              stallId: stallMenuItems[index].stallId,
              sellerName: stallMenuItems[index].sellerName
            ));
            BlocProvider.of<PeoplePickCubit>(context).addPeoplePicks(addToCartEntity: AddToCartEntity(
                sellerUid: stallMenuItems[index].uid,
                quantity: _quantityCounter,
                isOrderPlace: false,
                customerUid: widget.userEntity.uid,
                customerName: widget.userEntity.name,
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
                                "price : ${stallMenuItems[index].menuPrice.toString()}",
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
