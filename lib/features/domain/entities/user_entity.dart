import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String emailAddress;
  final String gender;
  final String locations;
  final String name;
  final String phoneNumber;
  final String uid;
  final String profileUrl;
  final String accountType;
  final String stallName;

  UserEntity({
    this.emailAddress,
    this.gender,
    this.locations,
    this.name,
    this.phoneNumber,
    this.uid,
    this.profileUrl,
    this.accountType,
    this.stallName,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        emailAddress,
        gender,
        locations,
        name,
        phoneNumber,
        uid,
        profileUrl,
        accountType,
        stallName,
      ];
}
