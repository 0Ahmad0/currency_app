import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_app/controller/provider/profile_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../model/consts_manager.dart';
import '../../model/models.dart';
import '../../model/utils/const.dart';

import '../../translations/locale_keys.g.dart';
import '../utils/firebase.dart';

class OfficeProvider with ChangeNotifier{
 Users offices=Users(users: []);
 Users officesFavorite=Users(users: []);
 User office=User.init();
 bool price=false;
 bool location=false;
 fetchOffice({required String search}) async {
   var result;
   if(price)
     result= await fetchOfficeOrderByPrice();
   else if(location)
     result=await fetchOfficeOrderByLocation();
   else
     result=await fetchOfficeByTypeUser();
   if(result['status']){
     offices=Users.fromJson(result['body']);
     offices.users=searchOfficesByName(search, offices.users);
   }
   return result;

 }

 fetchOfficesFavorite(BuildContext context) async {
   ProfileProvider profileProvider=Provider.of<ProfileProvider>(context,listen: false);
   var result;
     result=await FirebaseFun.fetchUsersByTypeUserAndByList(typeUser: AppConstants.collectionOffice
         , nameList: 'id', list: profileProvider.user.favourite);
   if(result['status']){
     officesFavorite=Users.fromJson(result['body']);
   }else Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;

 }
 fetchOfficeByTypeUser() async {
   final result=await FirebaseFun.fetchUsersByTypeUser(AppConstants.collectionOffice);
   return result;

 }
 fetchOfficeOrderByPrice() async {
   final result=await FirebaseFun.fetchUsersByTypeUserOrderBy(AppConstants.collectionOffice, 'amount');
   return result;

 }
 fetchOfficeOrderByLocation() async {
   final result=await FirebaseFun.fetchUsersByTypeUserOrderBy(AppConstants.collectionOffice, 'amount');
   return result;
 }
 searchOfficesByName(String  search,List listSearch){
   List trimSearch=search.trim().split(' ');
   List<User> tempListSearch=[];
   for(User heritageElement in listSearch){
     if(heritageElement.name!.toLowerCase().contains(search.toLowerCase())){
       tempListSearch.add(heritageElement);
     }else{
       for(String element in trimSearch){
         if(heritageElement.name!.toLowerCase().contains(element.toLowerCase())){
           tempListSearch.add(heritageElement);
         }
       }
     }
   }
   return tempListSearch;
 }

 changeFavourite(context,{required String idUser}) async{
   ProfileProvider profileProvider=Provider.of<ProfileProvider>(context,listen: false);
   changeStateFavourite(context, idUser: idUser,user:profileProvider.user);
   var result =await FirebaseFun
       .updateUser(user: profileProvider.user);
   if(!result['status']){
     changeStateFavourite(context, idUser: idUser,user:profileProvider.user);
     Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   }
     return result;
 }
 changeStateFavourite(context,{required String idUser,required User user}) async{
   if(user.favourite.contains(idUser))
     user.favourite.remove(idUser);
   else
     user.favourite.add(idUser);
   return user;
 }


 Future uploadFile({required String filePath,required String typePathStorage}) async {
   try {
     String path = basename(filePath);
     print(path);
     File file =File(filePath);

//FirebaseStorage storage = FirebaseStorage.instance.ref().child(path);
     Reference storage = FirebaseStorage.instance.ref().child("${typePathStorage}${path}");
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
  onError(error){
    print(false);
    print(error);
    return {
      'status':false,
      'message':error,
      //'body':""
    };
  }
}
