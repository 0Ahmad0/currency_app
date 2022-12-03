import 'package:currency_app/translations/locale_keys.g.dart';
import 'package:currency_app/view/manager/widgets/ShadowContainer.dart';
import 'package:currency_app/view/resourse/assets_manager.dart';
import 'package:currency_app/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: tr(LocaleKeys.search),
              prefixIcon: IconButton(onPressed: (){},
              icon: Icon(Icons.search),)
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx,index)=>BuildOfficeTransferItem(),
          ),
        ),
      ],
    );
  }
}

class BuildOfficeTransferItem extends StatelessWidget {
  const BuildOfficeTransferItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      padding: AppPadding.p10,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Column(
            children: [
              ListTile(
                title: Text("Alwaseem Office"),
              leading: Icon(Icons.person),
              ),
              ListTile(
                title: Text("Al-Madenah"),
              leading: Icon(Icons.location_on),
              ),
            ],
          )),
          Expanded(
            child: Container(
              height: 16.h,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(AppSize.s14)
              ),
              child: Image.asset(AssetsManager.logoIMG),
            ),
          )
        ],
      ),
    );
  }
}

