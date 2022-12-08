import 'package:flutter/material.dart';

import '../manager/widgets/build_office_item.dart';
import '../resourse/assets_manager.dart';
import '../resourse/color_manager.dart';
import '../resourse/values_manager.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: 2,
      itemBuilder: (ctx, index) => BuildOfficeTransferItem(
        index: index +1,
        officeName: "Alwassemedfnbjndfnbjdnfjbnjdfbjdfnjn",
        distance: "98.54 KM",
        ammount: "2",
        img: AssetsManager.logoIMG,
      ),
    );
  }
}
/*
//TODO add if you want
          Container(
            padding: const EdgeInsets.all(AppPadding.p12),
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m12),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle),
            child:  Icon(
                Icons.favorite ,
                size: AppSize.s30 ,
                color: ColorManager.error
            ),
          ),

 */
