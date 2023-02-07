import 'dart:io';

import 'package:currency_app/controller/provider/profile_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:path/path.dart';
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/home/home_view.dart';
import '../view/navbar/navbar.dart';

class ProfileController{
  late ProfileProvider profileProvider;
  var context;
  ProfileController({required this.context}){
    profileProvider= Provider.of<ProfileProvider>(context);
  }
  Future uploadImage({required XFile image}) async {
    try {
      String path = basename(image!.path);
      print(image!.path);
      File file =File(image!.path);
      //FirebaseStorage storage = FirebaseStorage.instance.ref().child(path);
      Reference storage = FirebaseStorage.instance.ref().child("profileImage/${path}");
      UploadTask storageUploadTask = storage.putFile(file);
      TaskSnapshot taskSnapshot = await storageUploadTask;
      //Const.LOADIG(context);
      String url = await taskSnapshot.ref.getDownloadURL();
      //Navigator.of(context).pop();
      print('url $url');
      return url;
    } catch (ex) {
      //Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
    }
  }


}