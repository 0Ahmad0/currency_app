import 'package:country_flags/country_flags.dart';
import 'package:currency_app/translations/locale_keys.g.dart';
import 'package:currency_app/view/manager/widgets/ShadowContainer.dart';
import 'package:currency_app/view/resourse/assets_manager.dart';
import 'package:currency_app/view/resourse/color_manager.dart';
import 'package:currency_app/view/resourse/style_manager.dart';
import 'package:currency_app/view/resourse/values_manager.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class CurrencyOfficeViewBody extends StatefulWidget {
  @override
  State<CurrencyOfficeViewBody> createState() => _CurrencyOfficeViewBodyState();
}

class _CurrencyOfficeViewBodyState extends State<CurrencyOfficeViewBody> {
  final fromController = TextEditingController();

  final toController = TextEditingController();

  var flagFrom = "SA";
  var flagTo= "US";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: AssetsManager.logoIMG,
            child: Container(
                alignment: Alignment.center,
                height: 24.h,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: SafeArea(child: Image.asset(AssetsManager.logoIMG))),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          ListTile(
            title: Text("ALwaseem Office"),
            leading: Icon(Icons.factory),
          ),
          ListTile(
            title: Text("Taiba - 13.6 KM"),
            leading: Icon(Icons.location_on),
          ),
          ListTile(
            title: Text.rich(TextSpan(children: [
              TextSpan(text: "2"),
              TextSpan(
                  text: " %",
                  style:
                      getBoldStyle(color: ColorManager.error, fontSize: 20.sp)),
            ])),
            leading: Icon(Icons.money_off),
          ),
          Divider(
            color: Colors.black,
          ),
          ShadowContainer(
            color: Theme.of(context).cardColor,
              child: Column(
            children: [
              TextFormField(

                controller: toController,
                decoration: InputDecoration(
                  icon: GestureDetector(
                      onTap: (){
                        showCurrencyPicker(
                            context: context,
                            onSelect: (Currency currency){
                              flagFrom= currency.code.substring(0,currency.code.length-1);
                              setState(() {

                              });
                            }
                        );
                      },
                      child: CountryFlags.flag(
                        flagFrom,
                        width: 30.0,
                        height: 30.0,

                      ),
                  ),
                    hintText: tr(LocaleKeys.from),

                ),
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
//              GestureDetector(
//                onTap: (){},
//                child: CircleAvatar(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//
//                      Icon(Icons.arrow_upward,size: 10.sp,),
//                      Icon(Icons.arrow_downward,size: 10.sp,),
//                    ],
//                  ),
//                ),
//              ),
//              const SizedBox(
//                height: AppSize.s10,
//              ),
              TextFormField(
                controller: toController,
                decoration: InputDecoration(
                  hintText: tr(LocaleKeys.to),
                  icon: GestureDetector(
                    onTap: (){
                      showCurrencyPicker(
                          context: context,
                          onSelect: (Currency currency){
                            flagTo= currency.code.substring(0,currency.code.length-1);
                            setState(() {

                            });
                          }
                      );
                    },
                    child: CountryFlags.flag(
                      flagTo,
                      width: 30.0,
                      height: 30.0,

                    ),
                  ),

                ),
              ),

            ],
          ))
        ],
      ),
    );
  }
}
