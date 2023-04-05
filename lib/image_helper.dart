import 'dart:convert';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:flutter/services.dart';

class ImageHelper{
  ImageHelper({ImagePicker? imagePicker}) : _imagePicker = imagePicker ?? ImagePicker();

  final ImagePicker _imagePicker;
  String _base64 = "";


  Future<XFile?>pickImage({
    ImageSource source = ImageSource.gallery,
  }) async{

    final XFile? imageX = await _imagePicker.pickImage(source: source);
    Uint8List imageByte = await imageX!.readAsBytes();
    _base64 = base64.encode(imageByte);
    print(_base64);


    return await _imagePicker.pickImage(
        source: source
    );
  }

  Future<XFile?>imageUpdate({
    ImageSource source = ImageSource.gallery,
  }) async{

    final XFile? imageX = await _imagePicker.pickImage(source: source);
    Uint8List imageByte = await imageX!.readAsBytes();
    _base64 = base64.encode(imageByte);
    print(_base64);


    return await _imagePicker.pickImage(
        source: source
    );
  }

  String sendBase64(){
    print("RETURNED BASE 64");
    return _base64;
  }

  /*
  void _pickImageBase64() async{
    //final XFile? imageX = await _imagePicker.pickImage(source: ImageSource.gallery);
    final XFile? imageX = await _imagePicker.pickImage(source: source);
    Uint8List imageByte = await imageX!.readAsBytes();
    String _base64 = base64.encode(imageByte);
    print(_base64);
  }
*/

/*
  Future<XFile?>pickImage({
    ImageSource source = ImageSource.gallery,
  }) async{



    return await _imagePicker.pickImage(
      source: source
    ).then((imgFile){
      //Uint8List imageByte = imgFile!.readAsBytes();
    });
  }

  */
}