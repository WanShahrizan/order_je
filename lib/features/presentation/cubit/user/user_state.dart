part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserFailure extends UserState {
  @override
  List<Object> get props => [];
}
class UserSuccess extends UserState {
  final List<UserEntity> usersData;

  UserSuccess({this.usersData});
  @override
  List<Object> get props => [usersData];
}
class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

//stallMenu state
