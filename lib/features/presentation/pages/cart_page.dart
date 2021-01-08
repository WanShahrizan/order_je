import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/order_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:order_je/features/presentation/cubit/order/order_cubit.dart';
import 'package:order_je/features/presentation/widgets/common.dart';
import 'package:order_je/features/presentation/widgets/theme/style.dart';

class CartPage extends StatefulWidget {
  final UserEntity userEntity;

  const CartPage({Key key, this.userEntity}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _quantityCounter = 0;
  num _totalPrice = 0;

  @override
  void initState() {
    BlocProvider.of<AddToCartCubit>(context)
        .getCarts(uid: widget.userEntity.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                  'Cart',
                  style: TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
            ),
            SingleChildScrollView(
              child: BlocBuilder<AddToCartCubit, AddToCartState>(
                  builder: (context, AddToCartState addToCartState) {
                if (addToCartState is AddToCartLoaded) {
                  return addToCartState.addToCartData.isEmpty
                      ? Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 240),
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
                                  "No Cart Item",
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.black.withOpacity(.3)),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 170),
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                itemCount: addToCartState.addToCartData.length,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                reverse: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final cartData =
                                      addToCartState.addToCartData[index];
                                  return Slidable(
                                    actionPane: SlidableDrawerActionPane(),
                                    secondaryActions: [
                                      InkWell(
                                        onTap: (){
                                          BlocProvider.of<AddToCartCubit>(context).updateToCart(
                                            addToCartEntity: AddToCartEntity(
                                              cartId: cartData.cartId,
                                              customerUid: widget.userEntity.uid,
                                              menuPrice: _totalPrice.toString(),
                                              quantity: _quantityCounter,
                                              time: cartData.isOrderPlace==true?null:Timestamp.now(),
                                              isOrderPlace: cartData.isOrderPlace==false?true:false,
                                            ),
                                          );
                                          if (cartData.isOrderPlace==false){
                                            BlocProvider.of<OrderCubit>(context).addToOrder(
                                              orderEntity: OrderEntity(
                                                sellerUid: cartData.sellerUid,
                                                customerUid: cartData.customerUid,
                                                customerName: cartData.customerName,
                                                sellerName: cartData.sellerName,
                                                imageUrl: cartData.imageUrl,
                                                stallId: cartData.stallId,
                                                cartId: cartData.cartId,
                                                menuDescription: cartData.menuDescription,
                                                menuName: cartData.menuName,
                                                menuPrice: cartData.menuPrice,
                                                isOrderComplete: false,
                                                quantity: cartData.quantity,
                                                time: Timestamp.now(),
                                                orderId: "",
                                              )
                                            );
                                          }else if (cartData.isOrderPlace==true){
                                            BlocProvider.of<OrderCubit>(context).deleteFromOrder(
                                              orderEntity: OrderEntity(
                                                  sellerUid: cartData.sellerUid,
                                                  customerUid: cartData.customerUid,
                                                  customerName: cartData.customerName,
                                                  sellerName: cartData.sellerName,
                                                  imageUrl: cartData.imageUrl,
                                                  stallId: cartData.stallId,
                                                  cartId: cartData.cartId,
                                                  menuDescription: cartData.menuDescription,
                                                  menuName: cartData.menuName,
                                                  menuPrice: cartData.menuPrice,
                                                  isOrderComplete: false,
                                                  quantity: cartData.quantity,
                                                  time: Timestamp.now(),
                                                  orderId: ""
                                              )
                                            );
                                          }else{

                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                              gradient: LinearGradient(
                                                  colors: [
                                                Colors.orange,
                                                Colors.deepOrange,
                                              ],
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft)),
                                          child: Text(cartData.isOrderPlace==false?"Start Order":"Cancel Order",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                    ],
                                    child: InkWell(
                                      onTap: () {
                                        showAddToCartUpdateAlertDialog(
                                            context,
                                            addToCartState.addToCartData,
                                            index);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(13),
                                        height: 104,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: cartData.isOrderPlace==false?colorFEB727:color2BC205.withOpacity(.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Container(
                                                  height: 95,
                                                  width: 95,
                                                  margin:
                                                      EdgeInsets.only(left: 4),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            cartData.imageUrl,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: 12,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          cartData.menuName,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                            cartData.quantity ==
                                                                    1
                                                                ? "Single"
                                                                : "Double"),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      cartData.isOrderPlace==false?Text(""):Text("Order In Progress",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(right: 17),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Text(
                                                    'QTY',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          height: 22,
                                                          width: 25,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                          child: Icon(
                                                            Icons.remove,
                                                            size: 18,
                                                          )),
                                                      Container(
                                                        height: 22,
                                                        width: 25,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black)),
                                                        child: Text(
                                                          cartData.quantity
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 18),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      Container(
                                                          height: 22,
                                                          width: 25,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 18,
                                                          )),
                                                    ],
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        "RM ${cartData.menuPrice}"),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        );
                }
                return _loadingWidget();
              }),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       children: [
                //         Text(
                //           'Payment',
                //           style: TextStyle(fontSize: 20, color: Colors.black),
                //         ),
                //         SizedBox(
                //           width: 18,
                //         ),
                //         Container(
                //             padding: EdgeInsets.all(5),
                //             height: 27,
                //             width: 63,
                //             decoration: BoxDecoration(
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(20)),
                //               color: colorFEB727,
                //             ),
                //             child: Text(
                //               'Cash',
                //               style: TextStyle(
                //                 color: Colors.black,
                //               ),
                //               textAlign: TextAlign.center,
                //             )),
                //         SizedBox(
                //           width: 6,
                //         ),
                //         Container(
                //             padding: EdgeInsets.all(5),
                //             height: 27,
                //             width: 63,
                //             decoration: BoxDecoration(
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(20)),
                //               color: colorFEB727,
                //             ),
                //             child: Text(
                //               'Online',
                //               style: TextStyle(
                //                 color: Colors.black,
                //               ),
                //               textAlign: TextAlign.center,
                //             )),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Container(
                //             padding: EdgeInsets.only(bottom: 10),
                //             child: Text(
                //               'Total',
                //               style:
                //                   TextStyle(fontSize: 12, color: Colors.black),
                //             )),
                //         SizedBox(
                //           width: 2,
                //         ),
                //         Text(
                //           'RM 19.00',
                //           style: TextStyle(fontSize: 16, color: colorFEB727),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/loading.json',
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Please Wait for moment",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  showAddToCartUpdateAlertDialog(
      BuildContext context, List<AddToCartEntity> cartItem, int index) {
    // set up the button
    _totalPrice = num.parse(cartItem[index].menuPrice);
    _quantityCounter = cartItem[index].quantity;
    Widget buttons = Row(
      children: [
        InkWell(
          onTap: () {
            BlocProvider.of<AddToCartCubit>(context).deleteToCart(
                uid: widget.userEntity.uid, cartId: cartItem[index].cartId);
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              "Delete",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<AddToCartCubit>(context).updateToCart(
              addToCartEntity: AddToCartEntity(
                cartId: cartItem[index].cartId,
                customerUid: widget.userEntity.uid,
                menuPrice: _totalPrice.toString(),
                quantity: _quantityCounter,
                time: Timestamp.now(),
              ),
            );
            _totalPrice=null;
            _quantityCounter=null;
            Future.delayed(Duration(microseconds: 400), () {
              Navigator.pop(context);
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              "Update",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            _totalPrice=0;
            _quantityCounter=0;
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              "Done",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ],
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Update Cart"),
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
                            imageUrl: cartItem[index].imageUrl,
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
                            cartItem[index].menuName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "price : ${cartItem[index].menuPrice}",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                "Seller : ${cartItem[index].sellerName}",
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
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Icon(
                                          Icons.remove,
                                          size: 18,
                                        )),
                                  ),
                                  Container(
                                    height: 22,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
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
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                        )),
                                  ),
                                ],
                              ),
                              Text(
                                  "Total:${num.parse(cartItem[index].menuPrice) * _quantityCounter}")
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
                                  cartItem[index].menuDescription,
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
