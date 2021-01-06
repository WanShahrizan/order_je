import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/order_entity.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    String menuName,
    String menuPrice,
    String menuDescription,
    String imageUrl,
    bool isOrderComplete,
    String sellerUid,
    String customerUid,
    String stallId,
    String cartId,
    Timestamp time,
    String sellerName,
    String customerName,
    int quantity,
    String orderId,
  }) : super(
          menuName: menuName,
          menuPrice: menuPrice,
          menuDescription: menuDescription,
          imageUrl: imageUrl,
          isOrderComplete: isOrderComplete,
          sellerUid: sellerUid,
          customerUid: customerUid,
          stallId: stallId,
          cartId: cartId,
          time: time,
          sellerName: sellerName,
          customerName: customerName,
          quantity: quantity,
          orderId: orderId,
        );

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    return OrderModel(
      menuName: snapshot.data()['menuName'],
      menuPrice: snapshot.data()['menuPrice'],
      menuDescription: snapshot.data()['menuDescription'],
      imageUrl: snapshot.data()['imageUrl'],
      isOrderComplete: snapshot.data()['isOrderComplete'],
      sellerUid: snapshot.data()['sellerUid'],
      customerUid: snapshot.data()['customerUid'],
      stallId: snapshot.data()['stallId'],
      cartId: snapshot.data()['cartId'],
      time: snapshot.data()['time'],
      sellerName: snapshot.data()['sellerName'],
      customerName: snapshot.data()['customerName'],
      quantity: snapshot.data()['quantity'],
      orderId: snapshot.data()['orderId'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "menuName": menuName,
      "menuPrice": menuPrice,
      "menuDescription": menuDescription,
      "imageUrl": imageUrl,
      "isOrderComplete": isOrderComplete,
      "sellerUid": sellerUid,
      "customerUid": customerUid,
      "stallId": stallId,
      "cartId": cartId,
      "time": time,
      "sellerName": sellerName,
      "customerName": customerName,
      "quantity": quantity,
      "orderId": orderId,
    };
  }
}
