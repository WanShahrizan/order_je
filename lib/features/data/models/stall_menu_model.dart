import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';

class StallMenuModel extends StallMenuEntity {
  StallMenuModel({
    String menuName,
    String menuPrice,
    String menuDescription,
    String imageUrl,
    bool isMenuAvailable,
    String uid,
    String stallId,
    Timestamp time,
    String sellerName,
  }) : super(
          menuName: menuName,
          menuPrice: menuPrice,
          menuDescription: menuDescription,
          imageUrl: imageUrl,
          isMenuAvailable: isMenuAvailable,
          uid: uid,
          stallId: stallId,
          sellerName: sellerName,
        );

  factory StallMenuModel.fromSnapshot(DocumentSnapshot snapshot) {
    return StallMenuModel(
      menuName: snapshot.data()['menuName'],
      menuPrice: snapshot.data()['menuPrice'],
      menuDescription: snapshot.data()['menuDescription'],
      imageUrl: snapshot.data()['imageUrl'],
      isMenuAvailable: snapshot.data()['isMenuAvailable'],
      uid: snapshot.data()['uid'],
      stallId: snapshot.data()['stallId'],
      time: snapshot.data()['time'],
      sellerName: snapshot.data()['sellerName'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "menuName": menuName,
      "menuPrice": menuPrice,
      "menuDescription": menuDescription,
      "imageUrl": imageUrl,
      "isMenuAvailable": isMenuAvailable,
      "uid": uid,
      "stallId": stallId,
      "time": time,
      "sellerName": sellerName,
    };
  }
}
