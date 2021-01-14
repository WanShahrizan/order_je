import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:order_je/features/domain/entities/alert_oder_page_entity.dart';
import 'package:order_je/features/domain/entities/order_entity.dart';
import 'package:order_je/features/presentation/cubit/order/order_cubit.dart';
import 'package:order_je/features/presentation/widgets/theme/style.dart';

class AlertOrderPage extends StatefulWidget {
  final String uid;

  const AlertOrderPage({Key key, this.uid}) : super(key: key);

  @override
  _AlertOrderPageState createState() => _AlertOrderPageState();
}

class _AlertOrderPageState extends State<AlertOrderPage> {
  @override
  void initState() {
    print(widget.uid);
    BlocProvider.of<OrderCubit>(context).getOrders(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, OrderState orderState) {
            if (orderState is OrderLoaded) {
              final pendingOrders = orderState.orderData
                  .where((order) => order.isOrderComplete == false)
                  .toList();
              return Stack(
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
                    left: 20,
                    child: Container(
                      child: Text(
                        'Alert Order',
                        style: TextStyle(fontSize: 36, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 10,
                    child: Container(
                      child: Text(
                        'Pending Order',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 82,
                    right: 110,
                    child: Container(
                      child: Text(
                        "${pendingOrders.length}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 83,
                    right: 70,
                    child: Container(
                      height: 20,
                      width: 24,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(color: Colors.black)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 150),
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                    child: orderState.orderData.isEmpty
                        ? Container(
                            padding:
                                EdgeInsets.only(top: 70, left: 30, right: 30),
                            margin: EdgeInsets.only(
                                left: 30, right: 30, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "No Active Order",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(.3)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  FontAwesome.first_order,
                                  size: 98,
                                  color: Colors.black.withOpacity(.3),
                                )
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: orderState.orderData.length,
                            shrinkWrap: true,
                            reverse: true,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final orderData = orderState.orderData[index];
                              return Container(
                                margin: EdgeInsets.only(top: 30),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                height: 198,
                                width: 315,
                                decoration: BoxDecoration(
                                  color: orderData.isOrderComplete==false?colorFEB727:color2BC205.withOpacity(.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(top: 25),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Order:",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "#${orderData.orderId}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Image.asset(
                                                orderData.isOrderComplete ==
                                                        false
                                                    ? 'assets/allert.png'
                                                    : 'assets/done.png'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 0),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(bottom: 0),
                                            child: Text(
                                              "Time Order: ${DateFormat('h:m a').format(DateTime.fromMicrosecondsSinceEpoch(orderData.time.microsecondsSinceEpoch))}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Order',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: 20, bottom: 20),
                                            child: Text(
                                              'QTY',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 10, bottom: 30),
                                            child: Text(
                                              "${orderData.menuName}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: 20, bottom: 30),
                                            child: Text(
                                              '${orderData.quantity}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(""),
                                        InkWell(
                                          onTap: () {
                                            BlocProvider.of<OrderCubit>(context)
                                                .updateOrder(
                                                    orderEntity: OrderEntity(
                                              isOrderComplete:
                                                  orderData.isOrderComplete ==
                                                          false
                                                      ? true
                                                      : false,
                                              orderId: orderData.orderId,
                                              time: Timestamp.now(),
                                              stallId: orderData.stallId,
                                              quantity: orderData.quantity,
                                              sellerUid: orderData.sellerUid,
                                              cartId: orderData.orderId,
                                              customerUid:
                                                  orderData.customerUid,
                                              sellerName: orderData.sellerName,
                                              customerName:
                                                  orderData.customerName,
                                            ));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: orderData.isOrderComplete==false?Colors.green:Colors.orange,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Text("Order Ready"),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                  )
                ],
              );
            }
            return Stack(
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
                  top: 65,
                  left: 20,
                  child: Container(
                    child: Text(
                      'Alert Order',
                      style: TextStyle(fontSize: 36, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 10,
                  child: Container(
                    child: Text(
                      'Pending Order',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Positioned(
                  top: 82,
                  right: 110,
                  child: Container(
                    child: Text(
                      '0',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  top: 83,
                  right: 70,
                  child: Container(
                    height: 20,
                    width: 24,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(color: Colors.black)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 150),
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  child: Container(
                    padding: EdgeInsets.only(top: 70, left: 30, right: 30),
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Active Order",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(.3)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Icon(
                          FontAwesome.first_order,
                          size: 98,
                          color: Colors.black.withOpacity(.3),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
