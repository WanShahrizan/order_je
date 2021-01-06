import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_je/features/domain/entities/order_entity.dart';
import 'package:order_je/features/domain/use_cases/add_to_order_usecase.dart';
import 'package:order_je/features/domain/use_cases/delete_from_order_usecase.dart';
import 'package:order_je/features/domain/use_cases/get_orders_usecase.dart';
import 'package:order_je/features/domain/use_cases/update_order_usecase.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final AddToOrderCase addToOrderCase;
  final DeleteFromOrderCase deleteFromOrderCase;
  final GetOrderUseCase getOrderUseCase;
  final UpdateOrderUseCase updateOrderUseCase;
  OrderCubit({this.addToOrderCase,this.deleteFromOrderCase,this.getOrderUseCase,this.updateOrderUseCase}) : super(OrderInitial());


  Future<void> addToOrder({OrderEntity orderEntity})async{
    try{
      await  addToOrderCase.call(orderEntity);
    }on SocketException catch(_){
      emit(OrderFailure());
    }
  }
  Future<void> deleteFromOrder({OrderEntity orderEntity})async{
    try{
      await  deleteFromOrderCase.call(orderEntity);
    }on SocketException catch(_){
      emit(OrderFailure());
    }
  }
  Future<void> updateOrder({OrderEntity orderEntity})async{
    try{
      await  updateOrderUseCase.call(orderEntity);
    }on SocketException catch(_){
      emit(OrderFailure());
    }
  }
  Future<void> getOrders({String uid}) async {
    try {
      final streamResponse = getOrderUseCase.call(uid);
      streamResponse.listen((response) {
        emit(OrderLoaded(orderData: response));
      });
    } on SocketException catch (_) {
      emit(OrderFailure());
    }
  }


}
