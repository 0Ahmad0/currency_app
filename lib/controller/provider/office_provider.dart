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
import 'dart:math' as Math;
class OfficeProvider with ChangeNotifier{
 Users offices=Users(users: []);
 Users officesFavorite=Users(users: []);
 User office=User.init();
 bool price=false;
 bool location=false;
 fetchOffice(BuildContext context,{required String search}) async {
  ProfileProvider profileProvider=Provider.of<ProfileProvider>(context,listen: false);
  await profileProvider.getCurrentLocation();
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
     offices.users=await getDistanceFromLatLonInKmForList(profileProvider.user.latitude,profileProvider.user.longitude,offices.users);
   }
   return result;

 }

 fetchOfficesFavorite(BuildContext context) async {
   ProfileProvider profileProvider=Provider.of<ProfileProvider>(context,listen: false);
   await profileProvider.getCurrentLocation();
   var result;
     result=await FirebaseFun.fetchUsersByTypeUserAndByList(typeUser: AppConstants.collectionOffice
         , nameList: 'id', list: profileProvider.user.favourite);
   if(result['status']){
     officesFavorite=Users.fromJson(result['body']);
     officesFavorite.users=await getDistanceFromLatLonInKmForList(profileProvider.user.latitude,profileProvider.user.longitude,officesFavorite.users);
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

 getDistanceFromLatLonInKmForList(lat1,lon1,List<User> listUser){

   for(User user in listUser){
     user.distanceKm=getDistanceFromLatLonInKm(
       double.parse(lat1),
       double.parse(lon1),
       double.parse(user.latitude),
       double.parse(user.longitude),
     );
   }
   return listUser;
 }
 double getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {

   var R = 6371; // Radius of the earth in km
   var dLat = deg2rad(lat2-lat1);  // deg2rad below
   var dLon = deg2rad(lon2-lon1);

   var a =
       Math.sin(dLat/2) * Math.sin(dLat/2) +
           Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
               Math.sin(dLon/2) * Math.sin(dLon/2)
   ;
   var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
   var d = R * c; // Distance in km

   return d;
 }

 double deg2rad(deg) {
   return deg * (Math.pi/180);
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
