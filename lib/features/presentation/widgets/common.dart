

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as img;

String getNameOnly(String path) {
  return path
      .split('/')
      .last
      .split('%')
      .last
      .split("?")
      .first;
}

void push(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
}
Future<List<int>> compressImageSize({File file}) async {
  final bytes = file.readAsBytesSync();
  final image = img.decodeImage(bytes);
  final resizeImage = img.copyResize(image, width: 500);
  final compressImageBytes = img.encodeJpg(resizeImage, quality: 50);
  return compressImageBytes;
}

void toast({String message}){
  Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
  );
}