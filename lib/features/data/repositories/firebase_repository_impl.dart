



import 'package:order_je/features/data/data_sources/firebase_remote_data_source.dart';
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/order_entity.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/repositories/firebase_repository.dart';
import 'package:order_je/features/domain/use_cases/update_order_usecase.dart';

class FirebaseRepositoryImpl implements FirebaseRepository{
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({this.remoteDataSource});
  @override
  Future<void> getCreateCurrentUser(UserEntity userEntity) async => remoteDataSource.getCreateCurrentUser(userEntity);

  @override
  Future<String> getCurrentUid() async => remoteDataSource.getCurrentUid();

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signIn(String email, String password) async => remoteDataSource.signIn(email, password);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(String email, String password) async => remoteDataSource.signUp(email, password);

  @override
  Future<void> getAnalytics(String uid) async => remoteDataSource.getAnalytics(uid: uid);

  @override
  Future<void> getCrashlytics()async => remoteDataSource.getCrashlytics();

  @override
  Future<void> getPerformanceMonitoring() async => remoteDataSource.getPerformanceMonitoring();

  @override
  Future<void> pushNotification() async => remoteDataSource.pushNotification();

  @override
  Stream<List<UserEntity>> getAllUsers() => remoteDataSource.getAllUsers();

  @override
  Future<void> googleSignIn() async => remoteDataSource.googleSignIn();

  @override
  Future<void> getCreateStallMenu(StallMenuEntity stallMenuEntity) async =>
      remoteDataSource.getCreateStallMenu(stallMenuEntity);

  @override
  Stream<List<StallMenuEntity>> getStallMenu() => remoteDataSource.getStallMenu();

  @override
  Future<void> getUpdateStallMenu(StallMenuEntity stallMenuEntity) async
  => remoteDataSource.getUpdateStallMenu(stallMenuEntity);

  @override
  Future<void> getDeleteStallMenu(String stallMenuId) async =>
      remoteDataSource.getDeleteStallMenu(stallMenuId);

  @override
  Future<void> addToCart(AddToCartEntity addToCartEntity) async =>
      remoteDataSource.addToCart(addToCartEntity);

  @override
  Future<void> deleteToCart(String cartId,String uid) async =>
       remoteDataSource.deleteToCart(cartId,uid);

  @override
  Future<void> updateToCart(AddToCartEntity addToCartEntity) async =>
      remoteDataSource.updateToCart(addToCartEntity);

  @override
  Stream<List<AddToCartEntity>> getCarts(String uid) =>
      remoteDataSource.getCarts(uid);

  @override
  Future<void> peoplePicks(AddToCartEntity addToCartEntity) async =>
       remoteDataSource.peoplePicks(addToCartEntity);

  @override
  Stream<List<AddToCartEntity>> getPeoplePicks() =>
      remoteDataSource.getPeoplePicks();

  @override
  Future<void> forgetPassword(String email) async => remoteDataSource.forgetPassword(email);

  @override
  Future<void> addToOrder(OrderEntity orderEntity) async => remoteDataSource.addToOrder(orderEntity);

  @override
  Future<void> deleteFromOrder(OrderEntity orderEntity) async =>
      remoteDataSource.deleteFromOrder(orderEntity);

  @override
  Stream<List<OrderEntity>> getOrders(String uid) =>
      remoteDataSource.getOrders(uid);

  @override
  Future<void> updateOrder(OrderEntity orderEntity) {
    return remoteDataSource.updateOrder(orderEntity);
  }
}