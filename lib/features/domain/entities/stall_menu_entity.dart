import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StallMenuEntity extends Equatable {
  final String menuName;
  final String menuPrice;
  final String menuDescription;
  final String imageUrl;
  final bool isMenuAvailable;
  final String uid;
  final String stallId;
  final Timestamp time;
  final String sellerName;

  StallMenuEntity({
    this.menuName,
    this.menuPrice,
    this.menuDescription,
    this.imageUrl,
    this.isMenuAvailable,
    this.uid,
    this.stallId,
    this.time,
    this.sellerName,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        menuName,
        menuPrice,
        menuDescription,
        imageUrl,
        isMenuAvailable,
        uid,
        stallId,
        time,
        this.sellerName
      ];
}
