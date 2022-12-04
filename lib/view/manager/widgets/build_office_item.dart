
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../currency_office/currency_office_view.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';
import 'ShadowContainer.dart';

class BuildOfficeTransferItem extends StatelessWidget {
  final String officeName;
  final String distance;
  final String ammount;
  final String img;
  final int index;

  const BuildOfficeTransferItem(
      {super.key,
        required this.officeName,
        required this.distance,
        required this.ammount,
        required this.img, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => CurrencyOfficeView(
        index: index,
      )),
      child: ShadowContainer(
        color: Theme.of(context).cardColor,
        padding: AppPadding.p10,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ListTile(

                      title: Text(officeName),
                      leading: Icon(Icons.person),
                    ),
                    ListTile(
                      title: Text(distance),
                      leading: Icon(Icons.location_on),
                    ),
                    ListTile(
                      title: Text.rich(
                          TextSpan(
                              children: [
                                TextSpan(text: ammount),
                                TextSpan(text: " %",
                                    style: getBoldStyle(
                                        color: ColorManager.error,
                                        fontSize: 22.sp

                                    )),
                              ]
                          )
                      ),
                      leading: Icon(Icons.money_off),
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                height: 16.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(AppSize.s14)),
                child: Hero(
                    tag: "${index}",
                    child: Image.asset(img)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
