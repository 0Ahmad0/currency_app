import 'package:currency_app/view/login/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../controller/form_validator.dart';
import '../../login/login_view.dart';
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

class SignupViewBody extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassworddController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  bool validatePassword(String value) {
    return regex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              FadeInLeftBig(
                  child: Image.asset(
                AssetsManager.logoIMG,
                    width: 100.w,
                    height: 20.h,
              )),
              const SizedBox(
                height: AppSize.s10,
              ),
              FadeInRight(
                child: ShadowContainer(
                    padding: AppPadding.p20,
                    color: Theme.of(context).cardColor,
                    shadowColor: Theme.of(context).textTheme.bodyMedium!.color!,
                    child: Column(
                      children: [
                        FadeInLeftBig(
                          child: TextFiledApp(
                              controller: nameController,
                              iconData: Icons.person,
                              hintText: tr(LocaleKeys.full_name)),
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        FadeInLeftBig(
                          child: TextFiledApp(
                            controller: emailController,
                            hintText: tr(LocaleKeys.email_address),
                            iconData: Icons.email,
                            validator: (val)=>FormValidator.emailValidator(val),
                        ),
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        FadeInLeftBig(
                          child: TextFiledApp(
                            controller: phoneController,
                            hintText: tr(LocaleKeys.mobile_number),
                            iconData: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (val)=>FormValidator.phoneValidator(val)
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        FadeInLeftBig(
                          child: TextFiledApp(
                            controller: passwordController,
                            obscureText: true,
                            suffixIcon: true,
                            hintText: tr(LocaleKeys.password),
                            iconData: Icons.lock,
                            validator: (val)=>FormValidator.passwordValidator(val)
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        FadeInLeftBig(
                          child: TextFiledApp(
                            controller: confirmPassworddController,
                            obscureText: true,
                            suffixIcon: true,
                            hintText: tr(LocaleKeys.confirm_password),
                            iconData: Icons.lock,
                            validator:(val)=>FormValidator.confirmPasswordValidator(passwordController.text,val)
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        FadeInLeftBig(
                          child: ButtonApp(
                              text: tr(LocaleKeys.signup),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {}
                              }),
                        ),
                        const SizedBox(
                          height: AppSize.s4,
                        ),
                        FadeInLeftBig(
                          child: TextButton(
                              onPressed: () {
                                Get.off(LoginView());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(tr(LocaleKeys.already_have_account)),
                                  Text(tr(LocaleKeys.login)),
                                ],
                              )),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
