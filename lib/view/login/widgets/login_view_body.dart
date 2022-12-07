import 'package:animate_do/animate_do.dart';
import 'package:currency_app/view/home/home_view.dart';
import 'package:currency_app/view/navbar/navbar.dart';
import 'package:currency_app/view/signup/signup_view.dart';
import '/translations/locale_keys.g.dart';
import '/view/manager/widgets/ShadowContainer.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/button_app.dart';
import '../../resourse/color_manager.dart';

class LoginViewBody extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgetPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  bool validatePassword(String value) {
    return regex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: SafeArea(
          child: Column(
            children: [
              FadeInLeftBig(child: Image.asset(AssetsManager.logoIMG)),
              const SizedBox(
                height: AppSize.s10,
              ),
              FadeInRight(
               child: ShadowContainer(
                 padding: AppPadding.p20,
                   color: Theme.of(context).cardColor,
                   shadowColor: Theme.of(context).textTheme.bodyMedium!.color!,
                   child: Column(
                 children: [  FadeInLeftBig(
                   child: TextFiledApp(
                       controller: emailController,
                       iconData: Icons.email,
                       hintText: tr(LocaleKeys.email_address)),
                 ),
                   const SizedBox(
                     height: AppSize.s20,
                   ),
                   FadeInLeftBig(
                     child: TextFiledApp(
                       controller: passwordController,
                       obscureText: true,
                       suffixIcon: true,
                       hintText: tr(LocaleKeys.password),
                       iconData: Icons.lock,
                       validator: (String? val) {
                         if (val!.length < 8 && !validatePassword(val!))
                           return tr(LocaleKeys.enter_strong_password);
                         return null;
                       },
                     ),
                   ),
                   const SizedBox(
                     height: AppSize.s10,
                   ),
                   FadeInLeftBig(
                     child: Row(
                       children: [
                         TextButton(
                             onPressed: () =>
                                 _showForgetPasswordDialog(context),
                             child: Text(tr(LocaleKeys.forget_password)))
                       ],
                     ),
                   ),
                   const SizedBox(
                     height: AppSize.s10,
                   ),
                   FadeInLeftBig(
                     child: ButtonApp(
                         text: tr(LocaleKeys.login),
                         onPressed: () {
                           if (formKey.currentState!.validate()) {
                             Get.to(()=>NavbarView());
                           }
                         }),
                   ),
                   const SizedBox(
                     height: AppSize.s4,
                   ),
                   FadeInLeftBig(
                     child: TextButton(
                         onPressed: () {
                           Get.off(SignupView());
                         },
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(tr(LocaleKeys.do_not_have_account)),
                             Text(tr(LocaleKeys.signup)),
                           ],
                         )),
                   )],
               )),
             )
            ],
          ),
        ),
      ),
    );
  }

  _showForgetPasswordDialog(BuildContext context) {
    Get.dialog(Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p20),
          margin: const EdgeInsets.all(AppMargin.m20),
          height: 25.h,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppSize.s14)),
          child: Column(
            children: [
              TextFiledApp(
                  controller: forgetPasswordController,
                  iconData: Icons.email,
                  hintText: tr(LocaleKeys.recovery_email)),
              Spacer(),
              ButtonApp(
                  textColor: Theme.of(context).textTheme.bodyMedium!.color,
                  text: tr(LocaleKeys.done),
                  onPressed: () {
                    Get.back();
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
