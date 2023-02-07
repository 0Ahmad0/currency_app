import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../login/login_view.dart';

import '/view/resourse/assets_manager.dart';
import '/view/resourse/values_manager.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  //  Future.delayed(Duration(seconds: 3),()=>Get.off(()=>LoginView()));
    return Center(
      child: FadeInDownBig(
        child: Image.asset(AssetsManager.logoIMG),
      ),
    );
  }
}
