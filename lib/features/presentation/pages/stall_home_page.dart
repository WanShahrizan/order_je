import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:order_je/features/presentation/cubit/stall_menu/stall_menu_cubit.dart';
import 'package:order_je/features/presentation/cubit/user/user_cubit.dart';
import 'package:order_je/features/presentation/widgets/common.dart';
import 'package:order_je/features/presentation/widgets/theme/style.dart';

import 'add_manu_page.dart';

class StallHomePage extends StatefulWidget {
  final UserEntity user;

  const StallHomePage({Key key, this.user}) : super(key: key);

  @override
  _StallHomePageState createState() => _StallHomePageState();
}

class _StallHomePageState extends State<StallHomePage> {
  bool _isDelete = false;

  String _descriptionUpdateText;
  String _priceUpdateText;
  String _nameUpdateText;

  @override
  void initState() {
    BlocProvider.of<StallMenuCubit>(context).getStallMenu();
    super.initState();
  }

  File _image;
  final picker = ImagePicker();

  FirebaseStorage _storage = FirebaseStorage.instance;
  bool _isFileUploading = false;
  String _downloadUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        toolbarHeight: 130,
        flexibleSpace: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/custom_header.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 30, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Text(
                          '',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                        InkWell(
                          onTap: () {
                            push(
                                context,
                                AddManuPage(
                                  user: widget.user,
                                ));
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 25, top: 10),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Colors.white)),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Add Menu',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 10),
                            margin: EdgeInsets.only(bottom: 0),
                            child: Text(
                              'Menu Offer',
                              style:
                                  TextStyle(fontSize: 26, color: Colors.white),
                            )),
                        InkWell(
                          onTap: () {
                            if (_isDelete == true)
                              setState(() {
                                _isDelete = false;
                              });
                            else
                              setState(() {
                                _isDelete = true;
                              });
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 25, top: 10),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Colors.white)),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Delete Menu',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<StallMenuCubit, StallMenuState>(
        builder: (BuildContext context, StallMenuState state) {
          if (state is UserStallMenuLoaded) {
            final stallMenuItems = state.stallMenuData
                .where((userItems) => userItems.uid == widget.user.uid)
                .toList();
            print(state.stallMenuData.length);
            return stallMenuItems.isEmpty
                ? Center(
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fastfood_outlined,
                            size: 98,
                            color: Colors.black.withOpacity(.3),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add Your Menu",
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.black.withOpacity(.3)),
                          ),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: ListView.builder(
                        itemCount: stallMenuItems.length,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    print(stallMenuItems[index].stallId);
                                    showTerminateAlertDialog(
                                        context, stallMenuItems, index);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 150,
                                    width: 362,
                                    decoration: BoxDecoration(
                                        color: colorFEB727,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 150,
                                          width: 150,
                                          padding: EdgeInsets.all(4),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            child: CachedNetworkImage(
                                              imageUrl: stallMenuItems[index]
                                                  .imageUrl,
                                              fit: BoxFit.fitHeight,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(top: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  stallMenuItems[index]
                                                      .menuName,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: "price :",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    TextSpan(
                                                      text:
                                                          "${stallMenuItems[index].menuPrice}",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ]),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(''),
                                                    InkWell(
                                                      onTap: () {
                                                        if (stallMenuItems[
                                                                    index]
                                                                .isMenuAvailable ==
                                                            true) {
                                                          BlocProvider.of<
                                                                      UserCubit>(
                                                                  context)
                                                              .getUpdateStallMenu(
                                                            stallMenuEntity: StallMenuEntity(
                                                                time: Timestamp
                                                                    .now(),
                                                                isMenuAvailable:
                                                                    false,
                                                                stallId:
                                                                    stallMenuItems[
                                                                            index]
                                                                        .stallId),
                                                          );
                                                          return;
                                                        }
                                                        if (stallMenuItems[
                                                                    index]
                                                                .isMenuAvailable ==
                                                            false) {
                                                          BlocProvider.of<
                                                                      UserCubit>(
                                                                  context)
                                                              .getUpdateStallMenu(
                                                            stallMenuEntity: StallMenuEntity(
                                                                time: Timestamp
                                                                    .now(),
                                                                isMenuAvailable:
                                                                    true,
                                                                stallId:
                                                                    stallMenuItems[
                                                                            index]
                                                                        .stallId),
                                                          );
                                                          return;
                                                        }
                                                        print(stallMenuItems[
                                                                index]
                                                            .isMenuAvailable);
                                                      },
                                                      child: Container(
                                                          // padding:
                                                          //     EdgeInsets.only(top: 8),
                                                          // margin: EdgeInsets.only(
                                                          //     right: 10, top: 14),
                                                          // height: 32,
                                                          // width: 160,
                                                          // decoration: BoxDecoration(
                                                          //     color: color2BC205,
                                                          //     borderRadius:
                                                          //         BorderRadius.all(
                                                          //             Radius.circular(
                                                          //                 8))),
                                                          // child: Text(
                                                          //   stallMenuItems[index]
                                                          //               .isMenuAvailable ==
                                                          //           true
                                                          //       ? "Make Menu UnAvailable"
                                                          //       : "Make Menu Available",
                                                          //   style: TextStyle(
                                                          //       fontSize: 14,
                                                          //       fontWeight:
                                                          //           FontWeight.bold),
                                                          //   textAlign:
                                                          //       TextAlign.center,
                                                          // ),
                                                          ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                _isDelete == false
                                    ? Text("")
                                    : Positioned(
                                        top: 10,
                                        right: 10,
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<UserCubit>(context)
                                                .getDeleteStallMenu(
                                                    stallMenuId:
                                                        stallMenuItems[index]
                                                            .stallId);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.red.withOpacity(.6),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          );
                        }),
                  ));
          }
          return _loadingWidget();
        },
      ),
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/loading.json',
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Please Wait for moment",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  showTerminateAlertDialog(
      BuildContext context, List<StallMenuEntity> stallMenuItems, int index) {
    // set up the button
    Widget doneButton = Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Text(
        "Done",
        style: TextStyle(fontSize: 18),
      ),
    );
    Widget updateButton = Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Text(
        "Update",
        style: TextStyle(fontSize: 18),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Update"),
      content: Container(
          height: 350,
          width: 500,
          color: colorFEB727,
          child: StatefulBuilder(
            builder: (_, setState) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          final pickedFile = await picker.getImage(
                              source: ImageSource.gallery);
                          if (mounted)
                            setState(() {
                              if (pickedFile != null) {
                                _image = File(pickedFile.path);
                                _isFileUploading = true;
                              } else {
                                print('No image selected.');
                              }
                            });
                          if (pickedFile != null) {
                            final data = await compressImageSize(file: _image);
                            _uploadImage(file: _image, bytesData: data);
                          }
                        },
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: _image == null
                                ? CachedNetworkImage(
                                    imageUrl: stallMenuItems[index].imageUrl,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  )
                                : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: TextEditingController(
                                text: stallMenuItems[index].menuName,
                              ),
                              onChanged: (value) {
                                _nameUpdateText = value;
                              },
                              decoration: InputDecoration(
                                hintText: "Name",
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                  "price :",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Expanded(
                                    child: TextField(
                                  controller: TextEditingController(
                                    text: stallMenuItems[index].menuPrice,
                                  ),
                                  onChanged: (value) {
                                    _priceUpdateText = value;
                                  },
                                  decoration:
                                      InputDecoration(hintText: "price"),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              constraints: BoxConstraints(maxHeight: 80),
                              child: Scrollbar(
                                child: TextField(
                                  maxLines: 4,
                                  onChanged: (value) {
                                    _descriptionUpdateText = value;
                                  },
                                  decoration:
                                      InputDecoration(hintText: "Description"),
                                  controller: TextEditingController(
                                      text: stallMenuItems[index]
                                          .menuDescription),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
      actions: [
        InkWell(
            onTap: () {
              setState(() {
                _nameUpdateText = null;
                _descriptionUpdateText = null;
                _priceUpdateText = null;
                _image = null;
                _downloadUrl = null;
              });
              Navigator.pop(context);
            },
            child: doneButton),
        InkWell(
            onTap: () {
              BlocProvider.of<UserCubit>(context).getUpdateStallMenu(
                stallMenuEntity: StallMenuEntity(
                    time: Timestamp.now(),
                    imageUrl: _downloadUrl,
                    menuDescription: _descriptionUpdateText,
                    menuName: _nameUpdateText,
                    menuPrice: _priceUpdateText,
                    stallId: stallMenuItems[index].stallId),
              );

              Future.delayed(
                  Duration(microseconds: 500), () => Navigator.pop(context));
            },
            child: updateButton),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _uploadImage({File file, List<int> bytesData}) async {
    final ref = _storage.ref().child(
        "Documents/${DateTime.now().millisecondsSinceEpoch}${getNameOnly(file.path)}");
    print("file ${file.path}");

    ref.putData(bytesData).snapshotEvents.listen((event) {
      print("status ${event.state}");
      if (event.state == TaskState.success) {
        setState(() {
          _isFileUploading = false;
          event.ref.getDownloadURL().then((value) {
            _downloadUrl = value;
          });
        });
      }
      print(
          "progressBar ${(event.totalBytes / event.bytesTransferred).toStringAsFixed(2)}");
    });
  }
}
