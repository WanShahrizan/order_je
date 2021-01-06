import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String emailAddress,
    String gender,
    String locations,
    String name,
    String phoneNumber,
    String uid,
    String profileUrl,
    String accountType,
    String stallName
  }) : super(
      emailAddress: emailAddress,
      gender: gender,
      locations: locations,
      name: name,
      phoneNumber: phoneNumber,
      uid: uid,
      profileUrl: profileUrl,
      accountType: accountType,
      stallName:stallName
  );


  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      name: snapshot.data()['name'],
      emailAddress: snapshot.data()['emailAddress'],
      phoneNumber: snapshot.data()['phoneNumber'],
      gender: snapshot.data()['gender'],
      uid: snapshot.data()['uid'],
      locations: snapshot.data()['locations'],
      profileUrl: snapshot.data()['profileUrl'],
      accountType: snapshot.data()['accountType'],
      stallName: snapshot.data()['stallName'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "emailAddress": emailAddress,
      "phoneNumber": phoneNumber,
      "gender": gender,
      "uid": uid,
      "locations": locations,
      "profileUrl": profileUrl,
      "accountType": accountType,
      "stallName": stallName,
    };
  }
}