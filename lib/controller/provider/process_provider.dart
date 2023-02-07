

import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';

import '../../model/consts_manager.dart';
import '../../model/models.dart' as models;
import '../../model/utils/const.dart';

import '../utils/firebase.dart';

class ProcessProvider with ChangeNotifier{
  Map<String,dynamic> cacheUser=Map<String,dynamic>();

  fetchLocalNameUser({required String idUser}) {
    //  print(cacheUser[idUser]);
    if(cacheUser.containsKey(idUser)) return cacheUser[idUser];
    return "......";
  }
  fetchNameUser(context,{required String idUser}) async{
  //  print(cacheUser[idUser]);
    if(cacheUser.containsKey(idUser)) return cacheUser[idUser];
    var result =await FirebaseFun.fetchUserId(id: idUser,typeUser: AppConstants.collectionUser);
    if(result['status']&&result['body']==null){
      result =await FirebaseFun.fetchUserId(id: idUser,typeUser: AppConstants.collectionOffice);
      if(result['status']&&result['body']==null){
        result =await FirebaseFun.fetchUserId(id: idUser,typeUser: AppConstants.collectionAdmin);
      }
    }
    cacheUser[idUser]=(result['status'])?models.User.fromJson(result['body']).name:"user";
    return cacheUser[idUser];
  }
  widgetNameUser(context,{required String idUser}){

    return FutureBuilder(
      future: fetchNameUser(
          context,
          idUser: idUser),
      builder: (
          context,
          snapshot,
          ) {
        print(snapshot
            .error);
        if (snapshot
            .connectionState ==
            ConnectionState
                .waiting) {
          return Const
                  .SHOWLOADINGINDECATOR();
          //Const.CIRCLE(context);
        } else if (snapshot
            .connectionState ==
            ConnectionState
                .done) {
          if (snapshot
              .hasError) {
            return const Text(
                'Error');
          } else if (snapshot
              .hasData) {
            // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
            //homeProvider.sessions=Sessions.fromJson(data['body']);
            return Text(
        '${cacheUser[idUser]}'
        );
          } else {
            return const Text(
                'Empty data');
          }
        } else {
          return Text(
              'State: ${snapshot.connectionState}');
        }
      },
    );
  }




}