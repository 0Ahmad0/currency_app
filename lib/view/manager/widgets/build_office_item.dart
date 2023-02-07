
import 'package:currency_app/controller/provider/office_provider.dart';
import 'package:currency_app/model/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../model/models.dart';
import '../../app/picture/cach_picture_widget.dart';
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
  final User office;

  const BuildOfficeTransferItem(
      {super.key,
        required this.officeName,
        required this.distance,
        required this.ammount,
        required this.img, required this.index, required this.office});

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () => Get.to(() => CurrencyOfficeView(
        index: index,
        office: office,
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
                    child: CacheNetworkImage(
                      photoUrl: '${office.photoUrl}',
                      width: 16.h,
                      height: 16.h,
                      waitWidget: Image.asset(img),
                      errorWidget: Image.asset(img),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
