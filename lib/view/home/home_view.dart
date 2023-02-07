import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:currency_app/controller/provider/office_provider.dart';
import 'package:currency_app/translations/locale_keys.g.dart';
import 'package:currency_app/view/currency_office/currency_office_view.dart';
import 'package:currency_app/view/manager/widgets/ShadowContainer.dart';
import 'package:currency_app/view/resourse/assets_manager.dart';
import 'package:currency_app/view/resourse/color_manager.dart';
import 'package:currency_app/view/resourse/style_manager.dart';
import 'package:currency_app/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../model/utils/const.dart';
import '../manager/widgets/build_office_item.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>{
  bool isShow = false;
  final searchController = TextEditingController();

  OfficeProvider officeProvider = OfficeProvider();
bool ani = true;
  @override
  Widget build(BuildContext context) {
    officeProvider=Provider.of<OfficeProvider>(context);
    return Column(
      children: [
        FadeInRightBig(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.zero,
                  hintText: tr(LocaleKeys.search),
                  prefixIcon: IconButton(
                    onPressed: () {
                      ani = !ani;

                      setState(() {
                      });
                      Future.delayed(Duration(milliseconds: 1000),(){

                        ani = true;
                        setState(() {

                        });
                      });


                    },
                    icon: Icon(Icons.search),
                  )),
            ),
          ),
        ),
        ChangeNotifierProvider<OfficeProvider>.value(
            value: Provider.of<OfficeProvider>(context),
            child: Consumer<OfficeProvider>(
                builder: (context, officeProvider, child)=>
        FutureBuilder(
          //prints the messages to the screen0
            future: officeProvider.fetchOffice(search: searchController.text),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return
                  (isShow)?
                  buildListSearch(context):
                  Const.SHOWLOADINGINDECATOR();
                ///waitListCategory(context);
              }
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  Const.SHOWLOADINGINDECATOR();
                  //print("aaa ${officeProvider.price} ${officeProvider.location}");
                  return buildListSearch(context);
                  /// }));
                } else {
                  return const Text('Empty data');
                }

            }),))
      ],
    );
  }
  buildListSearch(BuildContext context){
    isShow=officeProvider.offices.users.length>0;
    return Expanded(
      child: ListView.builder(
          itemCount: officeProvider.offices.users.length,
          itemBuilder: (ctx, index){
            // Timer(Duration(seconds: 2),(){
            //   isShow = true;
            //   setState(() {
            //   });
            // });
            officeProvider.office=officeProvider.offices.users[index];
            return isShow?
            FadeInLeftBig(
              animate: ani,
              child: BuildOfficeTransferItem(
                index: index,
                officeName: officeProvider.offices.users[index].name,
                distance: officeProvider.offices.users[index].location, //"98.54 KM",
                ammount: officeProvider.offices.users[index].amount,
                img: AssetsManager.logoIMG,
              ),
            )
                :SvgPicture.asset(
              AssetsManager.emptyIMG,
              width: 100,
              height: 100,
            );

          }
      ),
    );
  }
}
