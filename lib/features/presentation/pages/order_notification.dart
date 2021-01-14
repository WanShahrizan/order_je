import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:order_je/features/domain/entities/order_notification_entity.dart';
import 'package:order_je/features/presentation/cubit/order/order_cubit.dart';
import 'package:order_je/features/presentation/widgets/theme/style.dart';

class OrderNotificationPage extends StatefulWidget {
  final String uid;

  const OrderNotificationPage({Key key, this.uid}) : super(key: key);
  @override
  _OrderNotificationPageState createState() => _OrderNotificationPageState();
}

class _OrderNotificationPageState extends State<OrderNotificationPage> {
  final _data = OrderNotificationEntity.orderData;

  @override
  void initState() {
    BlocProvider.of<OrderCubit>(context).getOrders(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              top: 50,
              left: 20,
              child: Container(
                child: Text(
                  'Order Notification',
                  style: TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
            ),
            BlocBuilder<OrderCubit,OrderState>(
              builder: (context,orderState){
                if (orderState is OrderLoaded){
                  return  orderState.orderData.isEmpty?Container(
                    padding: EdgeInsets.only(top: 250,left: 60,right: 60),
                    margin: EdgeInsets.only(left: 30,right: 30,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No Active Order",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(.3)),),
                        SizedBox(height: 20,),
                        Icon(FontAwesome.first_order,size: 98,color: Colors.black.withOpacity(.3),)
                      ],
                    ),
                  ):Container(
                    padding: EdgeInsets.only(top: 150),
                    margin: EdgeInsets.only(left: 30,right: 30,bottom: 10),
                    child: ListView.builder(
                        itemCount: orderState.orderData.length,
                        shrinkWrap: true,
                        reverse: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                          final orderData=orderState.orderData[index];
                          return Container(
                            padding: EdgeInsets.only(left: 20,top: 20,right: 20),
                            margin: EdgeInsets.all(10),
                            height: 247,
                            width: 315,
                            decoration: BoxDecoration(
                              color: orderData.isOrderComplete==false?colorFEB727:color2BC205.withOpacity(.4),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Text("\#Order:",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                      Text("${orderData.orderId}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,fontStyle: FontStyle.italic),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text('Time Order'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text("${DateFormat("h:m a").format(DateTime.fromMicrosecondsSinceEpoch(orderData.time.microsecondsSinceEpoch))}"),
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text('Order Date'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text("${DateFormat().add_yMd().format(DateTime.fromMicrosecondsSinceEpoch(orderData.time.microsecondsSinceEpoch))}"),
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text('Paid With'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text("Cash"),
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text("${orderData.menuName}"),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text( "Qty: " + '${orderData.quantity}'),
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                                 SizedBox(height: 10,),
                                Container(
                                  child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text('Stall'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text("${orderData.sellerName}"),
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: Row(
                                      children: [
                                        Container(
                                            height: 22,
                                            width: 22,
                                            alignment: Alignment.centerRight,
                                            child: Image.asset(orderData.isOrderComplete==false?'assets/allert.png':'assets/done.png')
                                        ),
                                      ]
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(orderData.isOrderComplete==false?'Your order is in progress':'your order has been completed',style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(.3)),),
                              ],
                            ),
                          );
                        }),
                  );
                }
                return Container(
                  padding: EdgeInsets.only(top: 250,left: 60,right: 60),
                  margin: EdgeInsets.only(left: 30,right: 30,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No Active Order",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(.3)),),
                      SizedBox(height: 20,),
                      Icon(FontAwesome.first_order,size: 98,color: Colors.black.withOpacity(.3),)
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}