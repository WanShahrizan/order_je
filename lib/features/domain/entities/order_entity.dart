import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String menuName;
  final String menuPrice;
  final String menuDescription;
  final String imageUrl;
  final bool isOrderComplete;
  final String sellerUid;
  final String customerUid;
  final String stallId;
  final String cartId;
  final Timestamp time;
  final String sellerName;
  final String customerName;
  final int quantity;
  final String orderId;

  OrderEntity(
      {this.menuName,
      this.menuPrice,
      this.menuDescription,
      this.imageUrl,
      this.isOrderComplete,
      this.sellerUid,
      this.customerUid,
      this.stallId,
      this.cartId,
      this.time,
      this.sellerName,
      this.customerName,this.quantity,
        this.orderId,
      });

  @override
  // TODO: implement props
  List<Object> get props => [
    menuName, menuPrice, menuDescription, imageUrl, isOrderComplete, sellerUid, customerUid, stallId, cartId, time, sellerName, customerName,quantity,orderId
      ];
}
