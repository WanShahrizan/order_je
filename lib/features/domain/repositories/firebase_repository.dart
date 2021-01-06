


import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/order_entity.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';

abstract class FirebaseRepository{
  Future<void> signUp(String email,String password);
  Future<void> signIn(String email,String password);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<void> forgetPassword(String email);
  Future<String> getCurrentUid();
  Future<void> getCreateCurrentUser(UserEntity userEntity);
  Future<void> getAnalytics(String uid);
  Future<void> getCrashlytics();
  Future<void> getPerformanceMonitoring();
  Future<void> pushNotification();
  Stream<List<UserEntity>> getAllUsers();
  Future<void> googleSignIn();
  Future<void> getCreateStallMenu(StallMenuEntity stallMenuEntity);
  Future<void> getUpdateStallMenu(StallMenuEntity stallMenuEntity);
  Future<void> getDeleteStallMenu(String stallMenuId);
  Stream<List<StallMenuEntity>> getStallMenu();
  Future<void> addToCart(AddToCartEntity addToCartEntity);
  Future<void> deleteToCart(String cartId,String uid);
  Future<void> updateToCart(AddToCartEntity addToCartEntity);
  Stream<List<AddToCartEntity>> getCarts(String uid);
  Future<void> peoplePicks(AddToCartEntity addToCartEntity);
  Stream<List<AddToCartEntity>> getPeoplePicks();

  Future<void> addToOrder(OrderEntity orderEntity);
  Future<void> deleteFromOrder(OrderEntity orderEntity);
  Stream<List<OrderEntity>> getOrders(String uid);
  Future<void> updateOrder(OrderEntity orderEntity);


}