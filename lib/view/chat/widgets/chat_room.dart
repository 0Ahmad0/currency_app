
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:currency_app/translations/locale_keys.g.dart';
import 'package:currency_app/view/resourse/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import '../../../model/utils/app_sizer.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';
import 'dart:ui' as ui;
class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: GestureDetector(
        onTap: () {},
        child: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: ListTile(
            onTap: () {
              // Get.to(() => GroupSettingView(),
              //     transition: Transition.cupertinoDialog);
            },
            leading: Image.asset(
              AssetsManager.logoIMG,
              width: AppSize.s40,
              height: AppSize.s40,
            ),
            title: Text(
              "Alwasem ",
              style: getBoldStyle(
                color: ColorManager.lightGray,
              ),
            ),
          ),
        ),
      )),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(
              bottom: AppPadding.p60,
              left: AppPadding.p12,
              right: AppPadding.p12,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return MessageFile(
                index: index,
              );
            },
          ),
          Container(
            padding: const EdgeInsets.all(AppPadding.p8),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: ColorManager.black.withOpacity(.3),
                      blurRadius: AppSize.s4)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: TextField(
                  style: getRegularStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 15.sp
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: tr(LocaleKeys.type_here)
                  ),
                )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).cardColor,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MessageFile extends StatelessWidget {
  const MessageFile({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: "AppStrings.areYouSure",
          desc: "AppStrings.deleteThisMessage",
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
        margin: EdgeInsets.only(
          top: AppMargin.m10,
          bottom: AppMargin.m10,
          left: index.isEven ? 0 : AppSizer.getW(context) / 5,
          right: index.isOdd ? 0 : AppSizer.getW(context) / 5,
        ),
        decoration: BoxDecoration(
            color:
                index.isEven ? ColorManager.thirdlyColor
                    : Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s14),
              topRight: Radius.circular(AppSize.s14),
              bottomLeft: Radius.circular(index.isEven ? 0 : AppSize.s14),
              bottomRight: Radius.circular(index.isOdd ? 0 : AppSize.s14),
            ),
            boxShadow: [
              BoxShadow(
                  color: ColorManager.black.withOpacity(.5),
                  blurRadius: AppSize.s8)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p10
              ),
              child: Row(
                mainAxisAlignment: index.isOdd
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Text(
                    "Ahmad Alhariri",
                    style: getRegularStyle(
                        color: index.isOdd?Colors.black:Theme.of(context).cardColor
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text("Message")
             
            )
          ],
        ),
      ),
    );
  }
}
