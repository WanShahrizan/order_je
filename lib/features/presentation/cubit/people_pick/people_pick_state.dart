part of 'people_pick_cubit.dart';

abstract class PeoplePickState extends Equatable {
  const PeoplePickState();
}

class PeoplePickInitial extends PeoplePickState {
  @override
  List<Object> get props => [];
}

class PeoplePickLoading extends PeoplePickState {
  @override
  List<Object> get props => [];
}
class PeoplePickLoaded extends PeoplePickState {
  final List<AddToCartEntity> peoplePickData;

  PeoplePickLoaded({this.peoplePickData});
  @override
  List<Object> get props => [peoplePickData];
}
class PeoplePickFailure extends PeoplePickState {
  @override
  List<Object> get props => [];
}