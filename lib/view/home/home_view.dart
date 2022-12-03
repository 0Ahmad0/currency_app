import 'package:currency_app/translations/locale_keys.g.dart';
import 'package:currency_app/view/currency_office/currency_office_view.dart';
import 'package:currency_app/view/manager/widgets/ShadowContainer.dart';
import 'package:currency_app/view/resourse/assets_manager.dart';
import 'package:currency_app/view/resourse/color_manager.dart';
import 'package:currency_app/view/resourse/style_manager.dart';
import 'package:currency_app/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            itemBuilder: (ctx, index) => BuildOfficeTransferItem(
              officeName: "Alwassem",
              distance: "98.54 KM",
              ammount: "2",
              img: AssetsManager.logoIMG,
            ),
          ),
        ),
      ],
    );
  }
}

class BuildOfficeTransferItem extends StatelessWidget {
  final String officeName;
  final String distance;
  final String ammount;
  final String img;

  const BuildOfficeTransferItem(
      {super.key,
      required this.officeName,
      required this.distance,
      required this.ammount,
      required this.img});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => CurrencyOfficeView()),
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
                    tag: AssetsManager.logoIMG,
                    child: Image.asset(img)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
