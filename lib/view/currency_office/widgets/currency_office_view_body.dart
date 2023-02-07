import 'dart:async';

import 'package:country_flags/country_flags.dart';
import 'package:currency_app/controller/provider/chat_provider.dart';
import 'package:currency_app/controller/provider/currency_provider.dart';
import 'package:currency_app/controller/provider/profile_provider.dart';
import 'package:currency_app/model/consts_manager.dart';
import 'package:currency_app/model/models.dart';
import 'package:currency_app/model/utils/const.dart';
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
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/provider/office_provider.dart';

class CurrencyOfficeViewBody extends StatefulWidget {
  final int index;

  const CurrencyOfficeViewBody({super.key, required this.index});

  @override
  State<CurrencyOfficeViewBody> createState() => _CurrencyOfficeViewBodyState();
}

class _CurrencyOfficeViewBodyState extends State<CurrencyOfficeViewBody> {
  final fromController = TextEditingController();

  final toController = TextEditingController();

  var flagFrom = "SA";
  var currencyForm = "SAR";
  var currencyTo = "USD";
  var flagTo = "US";

  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    OfficeProvider officeProvider=Provider.of<OfficeProvider>(context);
    ProfileProvider profileProvider=Provider.of<ProfileProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 24.h,
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  child: Hero(
                      tag: '${widget.index}',
                      child: Image.asset(AssetsManager.logoIMG))),
              SafeArea(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(AppPadding.p4),
                    margin: const EdgeInsets.all(AppMargin.m12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        shape: BoxShape.circle),
                    child:
                    (AppConstants.collectionUser.contains(profileProvider.user.typeUser))?
                    ChangeNotifierProvider<ProfileProvider>.value(
                      value:Provider.of<ProfileProvider>(context),
                      child: Consumer<ProfileProvider>(
                        builder: (context,value , child){
                          isFav=value.user.favourite.contains(officeProvider.office.id);
                          return
                    IconButton(
                      onPressed: () async {
                        isFav = !isFav;
                        Const.LOADIG(context);
                        var result=await officeProvider.changeFavourite(context, idUser: officeProvider.office.id);
                        if(result['status'])
                         await ChatProvider().createChat(context, listIdUser: [value.user.id,officeProvider.office.id]);
                        Get.back();
                        value.notifyListeners();
                        officeProvider.notifyListeners();
                       // setState(() {});
                      },
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_outline,
                        size: isFav ? AppSize.s30 : AppSize.s20,
                        color: isFav ? ColorManager.error :
                        Theme.of(context).primaryColor,
                      ),
                    );}))
                        :SizedBox()
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          ListTile(
            title: Text(officeProvider.office.name),
            leading: Icon(Icons.factory),
          ),
          ListTile(
            title: Text(
              '${officeProvider.office.location}-${officeProvider.office.distanceKm.toStringAsFixed(2)} KM',
                //"Taiba - 13.6 KM"
            ),
            leading: Icon(Icons.location_on),
          ),
          ListTile(
            title: Text.rich(TextSpan(children: [
              TextSpan(text: officeProvider.office.amount),
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
          ChangeNotifierProvider<CurrencyProvider>.value(
          value:Provider.of<CurrencyProvider>(context),
    child: Consumer<CurrencyProvider>(
    builder: (context,currencyProvider , child){
      return ListBody(
        children: [
          ShadowContainer(
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  TextFormField(
                    controller: fromController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(AppPadding.p10),
                      icon: GestureDetector(
                        onTap: () {
                          showCurrencyPicker(
                              context: context,
                              onSelect: (Currency currency) {
                                flagFrom = currency.code
                                    .substring(0, currency.code.length - 1);
                                currencyForm=currency.code;
                                currencyProvider.notifyListeners();
                               // currencyProvider.currencyConvert.convert=Convert(from: flagFrom, to: to, amount: amount)
                               // setState(() {});
                              });
                        },
                        child: CountryFlags.flag(
                          flagFrom,
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                      hintText: currencyProvider.waitFrom?tr(LocaleKeys.loading):tr(LocaleKeys.from),
                    ),onFieldSubmitted: (val) async {
                      currencyProvider.currencyConvert.convert=
                          Convert(from: currencyForm, to: currencyTo, amount: double.parse(fromController.text));
                      currencyProvider.waitTo=true;
                      toController.text='';
                      currencyProvider.notifyListeners();
                       final result =await currencyProvider.convertCurrency(context, currencyConvert: currencyProvider.currencyConvert);
                      if(result['status']){
                        toController.text='${currencyProvider.currencyConvert.result+(currencyProvider.currencyConvert.result* double.parse(officeProvider.office.amount))}';
                      }
                      print('result ${ toController.text}');
                      currencyProvider.notifyListeners();
                  },
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

                      contentPadding: EdgeInsets.all(AppPadding.p10),
                      hintText: currencyProvider.waitTo?tr(LocaleKeys.loading):tr(LocaleKeys.to),
                      icon: GestureDetector(
                        onTap: () {
                          showCurrencyPicker(
                              context: context,
                              onSelect: (Currency currency) {
                                flagTo = currency.code
                                    .substring(0, currency.code.length - 1);
                                currencyTo=currency.code;
                                currencyProvider.notifyListeners();
                                //setState(() {});
                              });
                        },
                        child: CountryFlags.flag(
                          flagTo,
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                    ),
                    onFieldSubmitted: (val) async {
                      currencyProvider.currencyConvert.convert=
                          Convert(from: currencyTo, to: currencyForm, amount: double.parse(toController.text));
                      currencyProvider.waitFrom=true;
                      fromController.text='';
                      currencyProvider.notifyListeners();

                      final result =await currencyProvider.convertCurrency(context, currencyConvert: currencyProvider.currencyConvert);
                      if(result['status']){
                        fromController.text='${currencyProvider.currencyConvert.result+(currencyProvider.currencyConvert.result* double.parse(officeProvider.office.amount))}';
                      }
                      print('result ${ fromController.text}');
                      currencyProvider.notifyListeners();

                    },
                  ),
                ],
              )),

         // Text("${tr(LocaleKeys.total_amount)} 90.SR"),
        ],
      );

    }))
        ],
      ),
    );
  }
}
