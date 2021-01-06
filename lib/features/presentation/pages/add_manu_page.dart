import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_je/features/domain/entities/stall_menu_entity.dart';
import 'package:order_je/features/domain/entities/user_entity.dart';
import 'package:order_je/features/domain/use_cases/get_current_uid_usecase.dart';
import 'package:order_je/features/presentation/cubit/user/user_cubit.dart';
import 'package:order_je/features/presentation/widgets/common.dart';
import 'package:order_je/injection_container.dart' as di;

class AddManuPage extends StatefulWidget {
  final UserEntity user;

  const AddManuPage({Key key, this.user}) : super(key: key);
  @override
  _AddManuPageState createState() => _AddManuPageState();
}

class _AddManuPageState extends State<AddManuPage> {

  TextEditingController _menuNameController=TextEditingController();
  TextEditingController _menuPriceController=TextEditingController();
  TextEditingController _menuDescriptionController=TextEditingController();

  File _image;
  final picker = ImagePicker();

  FirebaseStorage _storage = FirebaseStorage.instance;
  bool _isFileUploading=false;
  String _downloadUrl="";

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState((){
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isFileUploading=true;
      } else {
        print('No image selected.');
      }
    });
    if (pickedFile!=null){
      final data=await compressImageSize(file: _image);
      _uploadImage(file: _image,bytesData: data);
    }
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _menuDescriptionController.dispose();
    _menuNameController.dispose();
    _menuPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/custom_header.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 55,
              left: 28,
              child: Container(
                child: Text(
                  'Add Menu',
                  style: TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        toolbarHeight: 130,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 30, right: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manu Name',
                  style: TextStyle(fontSize: 23),
                ),
                SizedBox(
                  height: 11,
                ),
                Container(
                  height: 49,
                  width: 306,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                     controller: _menuNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Menu Price (MYR)',
                  style: TextStyle(fontSize: 23),
                ),
                SizedBox(
                  height: 11,
                ),
                Container(
                  height: 49,
                  width: 306,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                    controller: _menuPriceController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Menu Description',
                  style: TextStyle(fontSize: 23),
                ),
                SizedBox(
                  height: 11,
                ),
                Container(
                  height: 49,
                  width: 306,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                    controller: _menuDescriptionController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Add Photo',
                  style: TextStyle(fontSize: 23),
                ),
                SizedBox(
                  height: 11,
                ),
                InkWell(
                  onTap: ()async {
                    getImage();
                  },
                  child: Container(
                    height: 149,
                    width: 167,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.blue)),
                    child: _image == null
                        ? Icon(
                            Icons.add_circle_outline,
                            color: Colors.blue,
                          )
                        : Stack(
                            children: [
                              Container(
                                height: 149,
                                width: 167,
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              _isFileUploading==false?Text(""):Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              Positioned(
                                  right: 5,
                                  top: 5,
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        _image=null;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(.6),
                                        borderRadius: BorderRadius.all(Radius.circular(8))
                                      ),
                                      child: Icon(Icons.close,color: Colors.white,),
                                    ),
                                  )),
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),


                InkWell(
                  onTap: (){
                    _addNewItem();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'Add',
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _uploadImage({File file, List<int> bytesData}) async {
    final ref = _storage.ref().child(
        "Documents/${DateTime
            .now()
            .millisecondsSinceEpoch}${getNameOnly(file.path)}");
    print("file ${file.path}");

   ref.putData(bytesData).snapshotEvents.listen((event) {
     print("status ${event.state}");
    if (event.state==TaskState.success){
      setState(() {
        _isFileUploading=false;
        event.ref.getDownloadURL().then((value) {
          _downloadUrl=value;
        });
      });
    }
    print("progressBar ${(event.totalBytes/event.bytesTransferred).toStringAsFixed(2)}");
   });
  }


  _addNewItem()async{

    if (_menuNameController.text.isEmpty){
      toast(message: "Enter Name");
      return;
    }
    if (_menuPriceController.text.isEmpty){
      toast(message: "Enter Prince");
      return;
    }

    if (_menuDescriptionController.text.isEmpty){
      toast(message: "Enter Description");
      return;
    }
    if (_downloadUrl.isEmpty){
      toast(message: "Select image");
      return;
    }
    if (_isFileUploading==true){
      toast(message: "Wait for moment image data checking");
      return;
    }
    final uid=await di.sl<GetCurrentUidUseCase>().call();
    BlocProvider.of<UserCubit>(context).getCreateStallMenu(
      stallMenuEntity: StallMenuEntity(
        stallId: _menuNameController.text,
        menuPrice: _menuPriceController.text,
        isMenuAvailable: true,
        uid: uid,
        menuName: _menuNameController.text,
        menuDescription: _menuDescriptionController.text,
        imageUrl: _downloadUrl,
        sellerName: widget.user.name
      ),
    );
    toast(message:"New Menu Added Successfully");
    _clear();
  }

  void _clear(){
    _menuNameController.clear();
    _menuPriceController.clear();
    _menuDescriptionController.clear();
    setState(() {
      _image=null;
      _downloadUrl=null;
    });
  }

}
