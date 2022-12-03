import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_app/view/manager/widgets/custom_listtile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../translations/locale_keys.g.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileProvider;
    return Column(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .primaryColor
          ),
          margin: EdgeInsets.zero,
          accountName: Text(
            tr(LocaleKeys.full_name),
            // value.user.name,
            style: getRegularStyle(
              color: ColorManager.white,
            ),
          ),
          accountEmail: Text(
            tr(LocaleKeys.email_address),
            // value.user.email,
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
          */Container(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .cardColor,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  width: 30.w,
                  height: 30.h,
                  imageUrl:
                  // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                  "https://live.staticflickr.com/1928/44477856474_882848622a_n.jpg",
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                          ),
                        ),
                      ),
                  placeholder: (context, url) =>
                      CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error),
                ),
              )
          ),
        ),
        CustomListTile(title: tr(LocaleKeys.setting), icon: Icons.settings),
         Divider(
          height: 0.0,
          color: Theme.of(context).primaryColor.withOpacity(.5),
        ),
        CustomListTile(title: tr(LocaleKeys.profile), icon: Icons.person),
        Divider(
          height: 0.0,
          color: Theme.of(context).primaryColor.withOpacity(.5),
        ),
        CustomListTile(title: tr(LocaleKeys.exit), icon: Icons.logout)

      ],
    );
  }
}
