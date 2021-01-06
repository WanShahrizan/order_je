import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';

class AddToCartModel extends AddToCartEntity {
  AddToCartModel({
    String menuName,
    String menuPrice,
    String menuDescription,
    String imageUrl,
    bool isOrderPlace,
    String sellerUid,
    String customerUid,
    String stallId,
    String cartId,
    Timestamp time,
    String sellerName,
    String customerName,
    int quantity,
  }) : super(
          menuName: menuName,
          menuPrice: menuPrice,
          menuDescription: menuDescription,
          imageUrl: imageUrl,
          isOrderPlace: isOrderPlace,
          sellerUid: sellerUid,
          customerUid: customerUid,
          stallId: stallId,
          cartId: cartId,
          time: time,
          sellerName: sellerName,
          customerName: customerName,
          quantity: quantity,
        );

  factory AddToCartModel.fromSnapshot(DocumentSnapshot snapshot) {
    return AddToCartModel(
      menuName: snapshot.data()['menuName'],
      menuPrice: snapshot.data()['menuPrice'],
      menuDescription: snapshot.data()['menuDescription'],
      imageUrl: snapshot.data()['imageUrl'],
      isOrderPlace: snapshot.data()['isOrderPlace'],
      sellerUid: snapshot.data()['sellerUid'],
      customerUid: snapshot.data()['customerUid'],
      stallId: snapshot.data()['stallId'],
      cartId: snapshot.data()['cartId'],
      time: snapshot.data()['time'],
      sellerName: snapshot.data()['sellerName'],
      customerName: snapshot.data()['customerName'],
      quantity: snapshot.data()['quantity'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "menuName": menuName,
      "menuPrice": menuPrice,
      "menuDescription": menuDescription,
      "imageUrl": imageUrl,
      "isOrderPlace": isOrderPlace,
      "sellerUid": sellerUid,
      "customerUid": customerUid,
      "stallId": stallId,
      "cartId": cartId,
      "time": time,
      "sellerName": sellerName,
      "customerName": customerName,
      "quantity": quantity,
    };
  }
}
