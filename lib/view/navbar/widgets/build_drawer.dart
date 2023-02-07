import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_app/model/utils/const.dart';
import 'package:currency_app/view/admin/add_office/add_office_view.dart';
import 'package:currency_app/view/login/login_view.dart';
import 'package:currency_app/view/manager/widgets/custom_listtile.dart';
import 'package:currency_app/view/profile/profile_view.dart';
import 'package:currency_app/view/setting/setting_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/provider/office_provider.dart';
import '../../../controller/provider/profile_provider.dart';
import '../../../model/consts_manager.dart';
import '../../../translations/locale_keys.g.dart';
import '../../app/picture/cach_picture_widget.dart';
import '../../app/picture/profile_picture_widget.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<ProfileProvider>.value(
    value: Provider.of<ProfileProvider>(context),
    child: Consumer<ProfileProvider>(
    builder: (context, value, child) =>
        Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .primaryColor
              ),
              margin: EdgeInsets.zero,
              accountName: Text(
                //tr(LocaleKeys.full_name),
                 value.user.name,
                style: getRegularStyle(
                  color: ColorManager.white,
                ),
              ),
              accountEmail: Text(
                //tr(LocaleKeys.email_address),
                 value.user.email,
                style: getLightStyle(
                  color: ColorManager.white,
                ),
              ),
              currentAccountPicture: /*
          value.user.photoUrl == null?
          ProfilePicture(
            name: value.user.name,
            radius: AppSize.s30,

          ):
          */GestureDetector(
                onTap: ()=>Get.to(()=>ProfileView()),
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .cardColor,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: CacheNetworkImage(
                        photoUrl: value.user.photoUrl,
                        width: 30.w,
                        height: 30.w,
                        waitWidget:  CircularProgressIndicator(),
                        errorWidget: WidgetProfilePicture(
                          name: value.user.name,
                          radius: 30.w,
                          backgroundColor: ColorManager.secondaryColor,
                          textColor: ColorManager.primaryColor,
                        ),
                      ),
                      // CachedNetworkImage(
                      //   fit: BoxFit.fill,
                      //   width: 30.w,
                      //   height: 30.h,
                      //   imageUrl:
                      //   // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                      //   "https://live.staticflickr.com/1928/44477856474_882848622a_n.jpg",
                      //   imageBuilder: (context, imageProvider) =>
                      //       Container(
                      //         decoration: BoxDecoration(
                      //           color: Theme
                      //               .of(context)
                      //               .primaryColor,
                      //           image: DecorationImage(
                      //             image: imageProvider,
                      //             fit: BoxFit.cover,
                      //             //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                      //           ),
                      //         ),
                      //       ),
                      //   placeholder: (context, url) =>
                      //       CircularProgressIndicator(),
                      //   errorWidget: (context, url, error) =>
                      //       Icon(Icons.error),
                      // ),
                    )
                ),
              ),
            ),
            CustomListTile(
                onTap: (){
                  Get.back();
                  Get.to(()=>SettingView());
                },
                title: tr(LocaleKeys.setting), icon: Icons.settings),
            Divider(
              height: 0.0,
              color: Theme.of(context).primaryColor.withOpacity(.5),
            ),
            CustomListTile(
                onTap: (){
                  Get.back();
                  Get.to(()=>ProfileView());
                },
                title: tr(LocaleKeys.profile), icon: Icons.person),
            if(value.user.typeUser.contains(AppConstants.collectionAdmin))
            Divider(
              height: 0.0,
              color: Theme.of(context).primaryColor.withOpacity(.5),
            ),
            if(value.user.typeUser.contains(AppConstants.collectionAdmin))
            CustomListTile(
                onTap: (){
                  Get.back();
                  Get.to(()=>AddOfficeView());
                },
                title: tr(LocaleKeys.add_office), icon: Icons.attach_money),
            Divider(
              height: 0.0,
              color: Theme.of(context).primaryColor.withOpacity(.5),
            ),
            CustomListTile(title: tr(LocaleKeys.exit),
                onTap: () async {
              Const.LOADIG(context);
              final result =await value.logout(context);
              Get.back();
              if(result['status'])
              Get.off(()=>LoginView());},
                icon: Icons.logout)

          ],
        )
    ));
  }
}
