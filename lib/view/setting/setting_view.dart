import 'package:animate_icons/animate_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/consts_manager.dart';
import '../../model/local/storage.dart';
import '/controller/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../model/models.dart';
import '../../translations/locale_keys.g.dart';
import '../resourse/color_manager.dart';
import '../resourse/style_manager.dart';
import '../resourse/values_manager.dart';

class SettingView extends StatelessWidget {
  bool language = false;
  bool theme = false;
  AnimateIconController c1 = AnimateIconController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.setting)),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p10,
          horizontal: AppPadding.p20,
        ),
        child: Column(
          children: [
            StatefulBuilder(builder: (context, mySetState) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: AppSize.s8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s14),
                    color: ColorManager.lightGray.withOpacity(.2)),
                child: Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    collapsedIconColor:
                    Theme.of(context).textTheme.bodyText2!.color,
                    iconColor: Theme.of(context).textTheme.bodyText2!.color,
                    tilePadding: EdgeInsets.only(
                      right: !Advance.language ? AppSize.s16 : 0,
                      left: !Advance.language ? 0 : AppSize.s16,
                    ),
                    title: ListTile(
                      title: Text(
                        tr(LocaleKeys.language),
                        style: getRegularStyle(
                            color: Theme.of(context).textTheme.bodyText2!.color,
                            fontSize: 15.sp),
                      ),
                      leading: Icon(
                        Icons.language,
                        color: ColorManager.lightGray,
                      ),
                      subtitle: Text(
                        !Advance.language
                            ? tr(LocaleKeys.english)
                            : tr(LocaleKeys.arabic),
                        style: getLightStyle(
                            fontSize: 12.sp,
                            color:
                            Theme.of(context).textTheme.bodyText2!.color),
                      ),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          tr(LocaleKeys.english),
                          style: getRegularStyle(
                            color: Theme.of(context).textTheme.bodyText2!.color,
                            fontSize: 14.sp,
                          ),
                        ),
                        leading: SizedBox(),
                        trailing: Switch(
                          activeColor: Theme.of(context).primaryColor,
                          value: !Advance.language,
                          onChanged: (val) async {
                            await context.setLocale(Locale('en'));
                            Get.updateLocale(context.locale);
                            AppStorage.storageWrite(
                                key: AppConstants.languageKEY, value: false);
                            Advance.language = false;
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          tr(LocaleKeys.arabic),
                          style: getRegularStyle(
                            color: Theme.of(context).textTheme.bodyText2!.color,
                            fontSize: 14.sp,
                          ),
                        ),
                        leading: SizedBox(),
                        trailing: Switch(
                          activeColor: Theme.of(context).primaryColor,
                          value: Advance.language,
                          onChanged: (val) async {
                            await context.setLocale(Locale('ar'));
                            // context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
                            Get.updateLocale(context.locale);
                            // //
                            AppStorage.storageWrite(
                                key: AppConstants.languageKEY, value: true);
                            Advance.language = true;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            ChangeNotifierProvider<ThemeProvider>.value(
              value: Provider.of<ThemeProvider>(context),
              child: Consumer<ThemeProvider>(
                  builder: (context,value,child) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: AppSize.s8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s14),
                          color: ColorManager.lightGray.withOpacity(.2)),
                      child: ListTile(
                          title: Text(
                            tr(LocaleKeys.theme),
                            style: getRegularStyle(
                                color: Theme.of(context).textTheme.bodyText2!.color,
                                fontSize: 15.sp),
                          ),
                          subtitle: Text(
                            value.isDark
                                ? tr(LocaleKeys.dark_mode)
                                : tr(LocaleKeys.light_mode),
                            style: getLightStyle(
                                fontSize: 14.sp,
                                color: Theme.of(context).textTheme.bodyText2!.color),
                          ),
                          leading: Icon(Icons.color_lens_outlined),
                          trailing: AnimateIcons(
                            startIconColor:
                            Theme.of(context).textTheme.bodyText2!.color,
                            endIconColor: Theme.of(context).textTheme.bodyText2!.color,
                            startIcon: value.isDark ? Icons.dark_mode : Icons.light_mode,
                            endIcon: value.isDark ? Icons.dark_mode : Icons.light_mode,
                            controller: c1,
                            onStartIconPress: () {
                              value.isDark = !value.isDark;
                              value.notifyListeners();
                              return false;
                            },
                            onEndIconPress: () {
                              value.isDark = !value.isDark;
                              value.notifyListeners();
                              return true;
                              // appModel.darkTheme = !appModel.darkTheme;
                              // return appModel.darkTheme;
                            },
                          )),
                    );
                  }

              ),
            ),

            // Text(tr(LocaleKeys.language),style: getBoldStyle(color: ColorManager.redOTP),)
          ],
        ),
      ),
    );
  }
}
