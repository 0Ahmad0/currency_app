
import 'package:currency_app/controller/provider/profile_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';


import '../../model/consts_manager.dart';
import '../../model/local/storage.dart';
import '../../model/models.dart';
import '../../model/utils/const.dart';

import '../../model/models.dart' as models;

import 'package:provider/provider.dart';

import '../utils/firebase.dart';

class AuthProvider with ChangeNotifier{
  var keyForm = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var phoneNumber = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  List<String> listTypeUserWithActive=[];//[AppConstants.collectionLawyer];
  models.User user= models.User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser",dateBirth: DateTime.now(),gender: "Male");
  signup(context) async{
    final profileProvider = Provider.of<ProfileProvider>(context,listen: false);
    bool checkPhoneOrEmailFound =await FirebaseFun.checkPhoneOrEmailFound(email:user.email, phone: user.phoneNumber);
    var result;
    if(checkPhoneOrEmailFound){
     result =await FirebaseFun.signup(email: user.email, password: user.password);
    if(result['status']){
      user.uid=result['body']?.uid;
      result = await FirebaseFun.createUser(user: user);
      if(result['status']){
        await AppStorage.storageWrite(key: AppConstants.isLoginedKEY, value: true);
        await AppStorage.storageWrite(key: AppConstants.idKEY, value: user.uid);
        await AppStorage.storageWrite(key: AppConstants.uidKEY, value: user.uid);
        await AppStorage.storageWrite(key: AppConstants.tokenKEY, value: "resultUser['token']");
        Advance.isLogined = true;
        user= models.User.fromJson(result['body']);
        profileProvider.updateUser(user:User.fromJson(result['body']));
      }
    }}
    else{
      result=FirebaseFun.errorUser("the email or phoneNumber already uses");
    }
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  signupAD(context) async{
    bool checkPhoneOrEmailFound =await FirebaseFun.checkPhoneOrEmailFound(email:user.email, phone: user.phoneNumber);
    var result;
    if(checkPhoneOrEmailFound){
      result =await FirebaseFun.signup(email: user.email, password: user.password);
      if(result['status']){
        user.uid=result['body']?.uid;
        result = await FirebaseFun.createUser(user: user);
        if(result['status']){
          user= models.User.fromJson(result['body']);
        }
      }}
    else{
      result=FirebaseFun.errorUser("the email or phoneNumber already uses");
    }
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  login(context) async{
    var result=await loginWithPhoneNumber(context);
    if(!result['status'])
      result=await loginWithEmil(context);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  loginWithEmil(context) async{
    var resultUser =await FirebaseFun.login(email: user.email, password: user.password);

    var result;
    if(resultUser['status']){
      resultUser = await fetchUser(uid: resultUser['body']?.uid);
      if(resultUser['status']&&listTypeUserWithActive.contains(resultUser['body']['typeUser'])&&!resultUser['body']['active'])
        result=FirebaseFun.errorUser("Account not Active");
      else
      result=await _baseLogin(context, resultUserAfterLog: resultUser);
    }else{
      result=resultUser;
    }
    return result;
  }
  loginWithPhoneNumber(context) async{

    var resultUser =await FirebaseFun.loginWithPhoneNumber(phoneNumber: user.email, password: user.password,typeUser: AppConstants.collectionUser);
    if(!resultUser["status"])
      resultUser =await FirebaseFun.loginWithPhoneNumber(phoneNumber: user.email, password: user.password,typeUser: AppConstants.collectionOffice);
    if(!resultUser["status"])
      resultUser =await FirebaseFun.loginWithPhoneNumber(phoneNumber: user.email, password: user.password,typeUser: AppConstants.collectionAdmin);
    if(resultUser['status'])
    {
      user= models.User.fromJson(resultUser['body']);
    }
    var result;
    result=await loginWithEmil(context);
    return result;
  }
  _baseLogin(context,{required var resultUserAfterLog}) async{

    final profileProvider = Provider.of<ProfileProvider>(context,listen: false);
    var result=resultUserAfterLog;
    if(result['status'])
    {
      await AppStorage.storageWrite(key: AppConstants.isLoginedKEY, value: true);
      Advance.isLogined = true;
      user= models.User.fromJson(result['body']);
      await AppStorage.storageWrite(key: AppConstants.idKEY, value: user.id);
      await AppStorage.storageWrite(key: AppConstants.uidKEY, value: user.uid);
      await AppStorage.storageWrite(key: AppConstants.isLoginedKEY, value: Advance.isLogined);
      await AppStorage.storageWrite(key: AppConstants.tokenKEY, value: "resultUser['token']");
      Advance.token = user.uid;
      Advance.uid = user.uid;
      email.clear();
      password.clear();
      profileProvider.updateUser(user:User.fromJson(result['body']));
    }
    return result;
  }


  loginUid(String uid) async{
    var result = await fetchUser(uid: uid);
    if(result['status']){
      await AppStorage.storageWrite(key: AppConstants.isLoginedKEY, value: true);
      Advance.isLogined = true;
      user= models.User.fromJson(result['body']);
      await AppStorage.storageWrite(key: AppConstants.idKEY, value: user.uid);
      Advance.token = user.uid;
      email.clear();
      password.clear();
      // print(result);
    }
    print(result);
    //Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
    /*if(result['status']){
    }else{
    }*/
    // user.uid=result['body']['uid'];
  }
  fetchUser({required String uid}) async {
    var result= await FirebaseFun.fetchUser(uid: uid, typeUser: AppConstants.collectionUser);
    // print(result);
    if(result['status']&&result['body']==null){
      result = await FirebaseFun.fetchUser(uid: uid, typeUser: AppConstants.collectionOffice);
      if(result['status']&&result['body']==null){

        result = await FirebaseFun.fetchUser(uid: uid, typeUser: AppConstants.collectionAdmin);
        if(result['status']&&result['body']==null){
          result={
            'status':false,
            'message': "account invalid"//LocaleKeys.toast_account_invalid,
          };
        }
      }
    }
    return result;
  }


 sendPasswordResetEmail(context,{required String resetEmail}) async{
    var result =await FirebaseFun.sendPasswordResetEmail(email: resetEmail);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  recoveryPassword(context,{required User user}) async{
    var result =await FirebaseFun.updatePassword(newPassword: user.password);
    if(result["status"])
      var resultUser =await FirebaseFun.updateUser(user: user);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
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

  loginByTypeUser(context,{required String typeUser}) async{
    var result=await loginWithPhoneNumberByTypeUser(context,typeUser: typeUser);
    if(!result['status'])
      result=await loginWithEmilByTypeUser(context,typeUser: typeUser);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  loginWithEmilByTypeUser(context,{required String typeUser}) async{
    var resultUser =await FirebaseFun.login(email: user.email, password: user.password);
    var result;
    if(resultUser['status']){
      resultUser = await fetchUserByTypeUser(uid: resultUser['body']?.uid,typeUser: typeUser);
      if(listTypeUserWithActive.contains(typeUser)&&!resultUser['body']['active'])
        result=FirebaseFun.errorUser("Account not Active");
      else
      result=await _baseLogin(context, resultUserAfterLog: resultUser);
    }else{
      result=resultUser;
    }
    return result;
  }
  loginWithPhoneNumberByTypeUser(context,{required String typeUser}) async{

    var resultUser =await FirebaseFun.loginWithPhoneNumber(phoneNumber: user.email, password: user.password,typeUser: typeUser);
    if(resultUser['status'])
    {
      user= models.User.fromJson(resultUser['body']);
    }
    var result;
    result=await loginWithEmilByTypeUser(context,typeUser: typeUser);
    return result;
  }
  fetchUserByTypeUser({required String uid,required typeUser}) async {
    var  result = await FirebaseFun.fetchUser(uid: uid, typeUser: typeUser);
    if(result['status']&&result['body']==null){
      result={
        'status':false,
        'message': "account invalid"//LocaleKeys.toast_account_invalid,
      };
    }
    return result;
  }
  Future uploadImage(context,XFile image) async {
    //Const.LOADIG(context);
    var url=await FirebaseFun.uploadImage(image: image,folder: "profileImage");
    print('url $url');
    if(url==null)
      Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
    else{
      return url;
    }
    return '';
    //Navigator.of(context).pop();
  }
}

