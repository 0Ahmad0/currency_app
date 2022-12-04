import 'package:currency_app/translations/locale_keys.g.dart';
import 'package:currency_app/view/manager/widgets/button_app.dart';
import 'package:currency_app/view/resourse/assets_manager.dart';
import 'package:currency_app/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../manager/widgets/textformfiled_app.dart';

class AddOfficeViewBody extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p12),
        children: [
          SafeArea(child: Image.asset(AssetsManager.addCurrencyIMG)),
          TextFiledApp(
            iconData: Icons.person,
            hintText: 'Appstring.officename',
          ),
          const SizedBox(height: AppSize.s10,),
          TextFiledApp(
            readOnly: true,
            onTap: (){
              //TODO put Location
            },
            iconData: Icons.location_on,
            hintText: 'Appstring.location',

          ),
          const SizedBox(height: AppSize.s10,),
          TextFiledApp(
            onTap: (){
              //TODO put Location
            },
            iconData: Icons.attach_money,
            hintText: 'Appstring.amount',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSize.s10,),
          ButtonApp(text: tr(LocaleKeys.done), onPressed: (){
            if(formKey.currentState!.validate()){}
          })
        ],
      ),
    );
  }
}
