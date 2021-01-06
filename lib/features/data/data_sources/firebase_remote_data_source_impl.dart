import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:order_je/features/data/models/add_to_cart_model.dart';
import 'package:order_je/features/data/models/order_model.dart';
import 'package:order_je/features/data/models/stall_menu_model.dart';
import 'package:order_je/features/data/models/user_model.dart';
import 'package:order_je/features/domain/entities/add_to_cart_entity.dart';
import 'package:order_je/features/domain/entities/order_entity.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';

import '../../../app_const.dart';
import 'firebase_remote_data_source.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final GoogleSignIn googleSignInAuth;
  final FirebaseAnalytics analytics;
  final FirebaseMessaging fcm;

  FirebaseRemoteDataSourceImpl({
    this.firestore,
    this.auth,
    this.analytics,
    this.googleSignInAuth,
    this.fcm,
  });

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection = firestore.collection("users");
    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        name: user.name,
        uid: uid,
        phoneNumber: user.phoneNumber,
        gender: user.gender,
        profileUrl: user.profileUrl,
        emailAddress: user.emailAddress,
        locations: user.locations,
        accountType: CUSTOMER,
        stallName: user.stallName,
      ).toDocument();
      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
        return;
      } else {
        userCollection.doc(uid).update(newUser);
        print("user already exist");
        return;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Future<String> getCurrentUid() async => auth.currentUser.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser.uid != null;

  @override
  Future<void> signIn(String email, String password) async {
    return await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.uid);
    });
  }

  @override
  Future<void> signOut() async {
    return await auth.signOut();
  }

  @override
  Future<void> signUp(String email, String password) async {
    return await auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> getAnalytics({String uid}) async {
    await analytics.setUserId(uid);
  }

  @override
  Future<void> getCrashlytics() {
    // TODO: implement getCrashlytics
    //Crashlaytics doesn't support flutter web because
    // that package is not supporting flutter web.
    //check official package link [https://pub.dev/packages/firebase_crashlytics]
    //And same package is supported in ANDROID and IOS
    //thats why we separated the file of ANDROID and IOS,
    // that we are sending you the source code in rar file fileName[checkerlia_mob.zip].
    throw UnimplementedError();
  }

  @override
  Future<void> getPerformanceMonitoring() {
    // TODO: implement getPerformanceMonitoring
    //check official package link [https://pub.dev/packages/firebase_performance]
    throw UnimplementedError();
  }

  @override
  Future<void> pushNotification() async {
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final userCollection = firestore.collection("users");
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> googleSignIn() async {
    try {
      final userCollection = firestore.collection("users");
      final GoogleSignInAccount account = await googleSignInAuth.signIn();
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final information = (await auth.signInWithCredential(credential)).user;
      userCollection.doc(auth.currentUser.uid).get().then((user) async {
        if (!user.exists) {
          var uid = auth.currentUser.uid;
          //TODO Initialize currentUser if not exist record
          final newUser = UserModel(
            name: information.displayName,
            uid: information.uid,
            phoneNumber: information.phoneNumber,
            gender: "",
            profileUrl: information.photoURL,
            emailAddress: information.email,
            locations: "",
            accountType: CUSTOMER,
            stallName: "",
          ).toDocument();

          userCollection.doc(information.uid).set(newUser);
        }
      }).whenComplete(() {
        print("New User Created Successfully");
      }).catchError((e) {
        print("getInitializeCreateCurrentUser ${e.toString()}");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> getCreateStallMenu(StallMenuEntity stallMenuEntity) async {
    final ref = firestore.collection("stallMenu");
    final String stallId =
        "${stallMenuEntity.menuName}-${DateTime.now().microsecondsSinceEpoch}";
    final newMenu = StallMenuModel(
      imageUrl: stallMenuEntity.imageUrl,
      menuDescription: stallMenuEntity.menuDescription,
      menuName: stallMenuEntity.menuName,
      uid: stallMenuEntity.uid,
      isMenuAvailable: stallMenuEntity.isMenuAvailable,
      menuPrice: stallMenuEntity.menuPrice,
      stallId: stallId,
      sellerName: stallMenuEntity.sellerName,
      time: Timestamp.now(),
    ).toDocument();

    ref.doc(stallId).set(newMenu);
  }

  @override
  Stream<List<StallMenuEntity>> getStallMenu() {
    final userCollection = firestore.collection("stallMenu");
    return userCollection.orderBy('time').snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => StallMenuModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> getUpdateStallMenu(StallMenuEntity stallMenuEntity) async {
    final userCollection = firestore.collection("stallMenu");

    Map<String, dynamic> userInformation = Map();

    if (stallMenuEntity.menuName != null)
      userInformation['menuName'] = stallMenuEntity.menuName;

    if (stallMenuEntity.menuPrice != null)
      userInformation['menuPrice'] = stallMenuEntity.menuPrice;

    if (stallMenuEntity.menuDescription != null)
      userInformation['menuDescription'] = stallMenuEntity.menuDescription;

    if (stallMenuEntity.imageUrl != null)
      userInformation['imageUrl'] = stallMenuEntity.imageUrl;

    if (stallMenuEntity.isMenuAvailable != null)
      userInformation['isMenuAvailable'] = stallMenuEntity.isMenuAvailable;

    if (stallMenuEntity.time != null)
      userInformation['time'] = stallMenuEntity.time;

    await userCollection.doc(stallMenuEntity.stallId).update(userInformation);
  }

  @override
  Future<void> getDeleteStallMenu(String stallMenuId) async {
    final userCollection = firestore.collection("stallMenu");
    userCollection.doc(stallMenuId).get().then((stallMenuItem) async {
      if (stallMenuItem.exists) {
        await userCollection.doc(stallMenuId).delete();
      }
    });
  }

  @override
  Future<void> addToCart(AddToCartEntity addToCartEntity) async {
    final myCartCollection = firestore
        .collection("users")
        .doc(addToCartEntity.customerUid)
        .collection("myCart");
    final String cartId = myCartCollection.doc().id;
    final newCart = AddToCartModel(
      sellerName: addToCartEntity.sellerName,
      stallId: addToCartEntity.stallId,
      cartId: cartId,
      menuPrice: addToCartEntity.menuPrice,
      menuName: addToCartEntity.menuName,
      menuDescription: addToCartEntity.menuDescription,
      imageUrl: addToCartEntity.imageUrl,
      time: Timestamp.now(),
      customerName: addToCartEntity.customerName,
      customerUid: addToCartEntity.customerUid,
      isOrderPlace: false,
      quantity: addToCartEntity.quantity,
      sellerUid: addToCartEntity.sellerUid,
    ).toDocument();

    myCartCollection.doc(cartId).set(newCart).catchError((error) {
      print(error);
    });
  }

  @override
  Future<void> deleteToCart(String cartId, String uid) async {
    final myCartCollection =
        firestore.collection("users").doc(uid).collection("myCart");

    await myCartCollection.doc(cartId).delete().catchError((error) {
      print(error);
    });
  }

  @override
  Future<void> updateToCart(AddToCartEntity addToCartEntity) async {
    final myCartCollection = firestore
        .collection("users")
        .doc(addToCartEntity.customerUid)
        .collection("myCart");

    Map<String, dynamic> userInformation = Map();

    if (addToCartEntity.time != null)
      userInformation['time'] = addToCartEntity.time;

    if (addToCartEntity.isOrderPlace != null)
      userInformation['isOrderPlace'] = addToCartEntity.isOrderPlace;

    if (addToCartEntity.quantity != null)
      userInformation['quantity'] = addToCartEntity.quantity;

    await myCartCollection.doc(addToCartEntity.cartId).update(userInformation);
  }

  @override
  Stream<List<AddToCartEntity>> getCarts(String uid) {
    final myCartCollection =
        firestore.collection("users").doc(uid).collection("myCart");

    return myCartCollection.orderBy('time').snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => AddToCartModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> peoplePicks(AddToCartEntity addToCartEntity) async {
    final myCartCollection = firestore.collection("peoplePicks");
    final String cartId = myCartCollection.doc().id;
    final newCart = AddToCartModel(
      sellerName: addToCartEntity.sellerName,
      stallId: addToCartEntity.stallId,
      cartId: cartId,
      menuPrice: addToCartEntity.menuPrice,
      menuName: addToCartEntity.menuName,
      menuDescription: addToCartEntity.menuDescription,
      imageUrl: addToCartEntity.imageUrl,
      time: Timestamp.now(),
      customerName: addToCartEntity.customerName,
      customerUid: addToCartEntity.customerUid,
      isOrderPlace: false,
      quantity: addToCartEntity.quantity,
      sellerUid: addToCartEntity.sellerUid,
    ).toDocument();

    myCartCollection.doc(cartId).set(newCart).catchError((error) {
      print(error);
    });
  }

  @override
  Stream<List<AddToCartEntity>> getPeoplePicks() {
    final myCartCollection = firestore.collection("peoplePicks");

    return myCartCollection.orderBy('time').snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => AddToCartModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> forgetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> addToOrder(OrderEntity orderEntity) async {
    final myOrderCollection = firestore
        .collection("users")
        .doc(orderEntity.customerUid)
        .collection("order");
    final otherOrderCollection = firestore
        .collection("users")
        .doc(orderEntity.sellerUid)
        .collection("order");

    final newOrder = OrderModel(
      isOrderComplete: orderEntity.isOrderComplete,
      time: Timestamp.now(),
      quantity: orderEntity.quantity,
      menuPrice: orderEntity.menuPrice,
      cartId: orderEntity.cartId,
      sellerName: orderEntity.sellerName,
      stallId: orderEntity.stallId,
      menuName: orderEntity.menuName,
      menuDescription: orderEntity.menuDescription,
      imageUrl: orderEntity.imageUrl,
      customerName: orderEntity.customerName,
      customerUid: orderEntity.customerUid,
      sellerUid: orderEntity.sellerUid,
      orderId: orderEntity.cartId,
    ).toDocument();

    await myOrderCollection.doc(orderEntity.cartId).set(newOrder);
    await otherOrderCollection.doc(orderEntity.cartId).set(newOrder);
  }

  @override
  Future<void> deleteFromOrder(OrderEntity orderEntity) async {
    final myOrderCollection = firestore
        .collection("users")
        .doc(orderEntity.customerUid)
        .collection("order");
    final otherOrderCollection = firestore
        .collection("users")
        .doc(orderEntity.sellerUid)
        .collection("order");

    await myOrderCollection.doc(orderEntity.cartId).delete();
    await otherOrderCollection.doc(orderEntity.cartId).delete();
  }

  @override
  Stream<List<OrderEntity>>  getOrders(String uid){
    final myOrderCollection = firestore
        .collection("users")
        .doc(uid)
        .collection("order");
    return myOrderCollection.orderBy('time').snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => OrderModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateOrder(OrderEntity orderEntity)async {
    final myOrderCollection = firestore
        .collection("users")
        .doc(orderEntity.customerUid)
        .collection("order");
    final otherOrderCollection = firestore
        .collection("users")
        .doc(orderEntity.sellerUid)
        .collection("order");
    Map<String, dynamic> userInformation = Map();

    if (orderEntity.time != null)
      userInformation['time'] = orderEntity.time;

    if (orderEntity.isOrderComplete != null)
      userInformation['isOrderComplete'] = orderEntity.isOrderComplete;

    await myOrderCollection.doc(orderEntity.orderId).update(userInformation);
    await otherOrderCollection.doc(orderEntity.orderId).update(userInformation);
  }
}
