part of 'stall_menu_cubit.dart';

abstract class StallMenuState extends Equatable {
  const StallMenuState();
}

class StallMenuInitial extends StallMenuState {
  @override
  List<Object> get props => [];
}

class UserStallMenuLoading extends StallMenuState {
  @override
  List<Object> get props => [];
}
class UserStallMenuLoaded extends StallMenuState {
  final List<StallMenuEntity> stallMenuData;

  UserStallMenuLoaded({this.stallMenuData});
  @override
  List<Object> get props => [stallMenuData];
}
class UserStallMenuFailure extends StallMenuState {
  @override
  List<Object> get props => [];
}