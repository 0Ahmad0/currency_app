import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:provider/provider.dart';

import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/home/home_view.dart';
import '../view/navbar/navbar.dart';
import 'provider/auth_provider.dart';

class AuthController{
  late AuthProvider authProvider;
  var context;
  AuthController({required this.context}){
    authProvider= Provider.of<AuthProvider>(context);
  }
  login(BuildContext context,{required String email,required String password,}) async {
    Const.LOADIG(context);
    authProvider.user.email=email;
    authProvider.user.password=password;
    final result=await authProvider.login(context);
    Get.back();
    if(result['status'])
      Get.off(() => NavbarView(),
          transition: Transition.circularReveal);

  }
  signUp(BuildContext context,{required String fullName,required String gender,required DateTime dateBirth,required String email,required String password,required String phoneNumber,required String photoUrl,required String typeUser}) async {
    Const.LOADIG(context);
    authProvider.user=User(id: '', uid: '',
        name: fullName,
        email: email,
        phoneNumber: phoneNumber
        , password: password,
        typeUser: typeUser,
        photoUrl: photoUrl,
        gender: gender,

        dateBirth: dateBirth);
    final result=await authProvider.signup(context);
    Get.back();
    if(result['status'])
      Get.off(() => NavbarView(),
          transition: Transition.circularReveal);
  }
  sendPasswordResetEmail(BuildContext context,{required String email}) async {
    Const.LOADIG(context);
    final result =await authProvider.sendPasswordResetEmail(context, resetEmail: email);
    Navigator.of(context).pop();
    if(result['status']){
      Get.back();
    }
  }
}