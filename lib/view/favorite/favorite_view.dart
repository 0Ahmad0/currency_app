import 'package:currency_app/controller/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/office_provider.dart';
import '../../model/utils/const.dart';
import '../manager/widgets/build_office_item.dart';
import '../resourse/assets_manager.dart';
import '../resourse/color_manager.dart';
import '../resourse/values_manager.dart';

class FavoriteView extends StatelessWidget {
   FavoriteView({Key? key}) : super(key: key);
OfficeProvider officeProvider=OfficeProvider();
  @override
  Widget build(BuildContext context) {
    officeProvider =Provider.of<OfficeProvider>(context);
    return ChangeNotifierProvider<OfficeProvider>.value(
        value: Provider.of<OfficeProvider>(context),
        child: Consumer<OfficeProvider>(
          builder: (context, officeProvider, child)=>
              FutureBuilder(
                //prints the messages to the screen0
                  future: officeProvider.fetchOfficesFavorite(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return
                        (officeProvider.officesFavorite.users.length>0)?
                        buildListSearch(context):
                        Const.SHOWLOADINGINDECATOR();
                      ///waitListCategory(context);
                    }
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      Const.SHOWLOADINGINDECATOR();
                      //print("aaa ${officeProvider.price} ${officeProvider.location}");
                      return
                        (officeProvider.officesFavorite.users.length>0)?
                        buildListSearch(context)
                      :SvgPicture.asset(
                          AssetsManager.emptyIMG,
                          width: 100,
                          height: 100,
                        );;
                      /// }));
                    } else {
                      return const Text('Empty data');
                    }

                  }),));
  }
  buildListSearch(BuildContext context){

    return  ListView.builder(
      itemCount: officeProvider.officesFavorite.users.length,
      itemBuilder: (ctx, index) {
        officeProvider.office=officeProvider.officesFavorite.users[index];
        return BuildOfficeTransferItem(
        index: index +1,
        officeName:officeProvider.officesFavorite.users[index].name,//"Alwassemedfnbjndfnbjdnfjbnjdfbjdfnjn",
        distance: "98.54 KM",
        ammount: officeProvider.officesFavorite.users[index].amount,//"2",
        img: AssetsManager.logoIMG,
      );},
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
