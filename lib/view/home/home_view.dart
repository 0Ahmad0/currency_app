import 'dart:async';

import 'package:currency_app/translations/locale_keys.g.dart';
import 'package:currency_app/view/currency_office/currency_office_view.dart';
import 'package:currency_app/view/manager/widgets/ShadowContainer.dart';
import 'package:currency_app/view/resourse/assets_manager.dart';
import 'package:currency_app/view/resourse/color_manager.dart';
import 'package:currency_app/view/resourse/style_manager.dart';
import 'package:currency_app/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../manager/widgets/build_office_item.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.zero,
                hintText: tr(LocaleKeys.search),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                )),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx, index){
              Timer(Duration(seconds: 2),(){
                isShow = true;
                setState(() {
                  
                });
              });
              return isShow?
              BuildOfficeTransferItem(
                index: index,
                officeName: "Alwassem",
                distance: "98.54 KM",
                ammount: "2",
                img: AssetsManager.logoIMG,
              )
                  :SvgPicture.asset(
                  AssetsManager.emptyIMG,
                width: 100,
                height: 100,
              );

            }
          ),
        ),
      ],
    );
  }
}
