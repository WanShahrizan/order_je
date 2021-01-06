import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/use_cases/get_people_picks_usecase.dart';
import 'package:order_je/features/domain/use_cases/people_pick_usecase.dart';

part 'people_pick_state.dart';

class PeoplePickCubit extends Cubit<PeoplePickState> {
  final GetPeoplePickUseCase getPeoplePickUseCase;
  final PeoplePickUseCase peoplePickUseCase;
  PeoplePickCubit({this.getPeoplePickUseCase,this.peoplePickUseCase}): super(PeoplePickInitial());

  Future<void> getPeoplePicks() async {
    try {
      final streamResponse = getPeoplePickUseCase.call();
      streamResponse.listen((response) {
        emit(PeoplePickLoaded(peoplePickData: response));
      });
    } on SocketException catch (_) {
      emit(PeoplePickFailure());
    }
  }
  Future<void> addPeoplePicks({AddToCartEntity addToCartEntity})async{
    try{
      await  peoplePickUseCase.call(addToCartEntity);
    }on SocketException catch(_){
      emit(PeoplePickFailure());
    }
  }


}
