import 'package:currency_app/controller/provider/profile_provider.dart';
import 'package:currency_app/translations/locale_keys.g.dart';
import 'package:currency_app/view/chat/chat_view.dart';
import 'package:currency_app/view/favorite/favorite_view.dart';
import 'package:currency_app/view/home/home_view.dart';
import 'package:currency_app/view/navbar/widgets/build_drawer.dart';
import 'package:currency_app/view/resourse/color_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/office_provider.dart';
import '../../model/consts_manager.dart';
import '../chart/chart_view.dart';

class NavbarView extends StatefulWidget {
  @override
  State<NavbarView> createState() => _NavbarViewState();
}

class _NavbarViewState extends State<NavbarView> {
  late List<Map<String, dynamic>> _screens;

  final controller = PersistentTabController();

  @override
  Widget build(BuildContext context) {
    OfficeProvider officeProvider =Provider.of<OfficeProvider>(context);;
    ProfileProvider profileProvider =Provider.of<ProfileProvider>(context);
    _screens=[];
    if([AppConstants.collectionUser,AppConstants.collectionAdmin].contains(profileProvider.user.typeUser))
      _screens.addAll([
        {
          "title": tr(LocaleKeys.home_page),
          "icon": Icons.home,
          "screen": HomeView(),
        },
      ]);
    if([AppConstants.collectionUser,AppConstants.collectionOffice].contains(profileProvider.user.typeUser))
      _screens.addAll([
        {
          "title": tr(LocaleKeys.chat_page),
          "icon": Icons.chat,
          "screen": ChatView()
        },
      ]);
    _screens.addAll([
      {
        "title": tr(LocaleKeys.rate_page),
        "icon": Icons.show_chart_rounded,
        "screen": ChartView()
      },


    ]);
      if([AppConstants.collectionUser].contains(profileProvider.user.typeUser))
      _screens.addAll([
        {
          "title": tr(LocaleKeys.favorite_page),
          "icon": Icons.favorite,
          "screen": FavoriteView()
        },
      ]);

    List<Widget> screen=[];
    for(var element in _screens){
      screen.add(element['screen']);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[controller.index]['title']),
        actions: [
          if (controller.index == 0&&_screens[controller.index]['title'].toString().contains(tr(LocaleKeys.home_page)))
            PopupMenuButton(
                icon: Icon(
                  Icons.filter_list,
                  color: ColorManager.lightGray,
                ),
                itemBuilder: (context) => [

                    PopupMenuItem(
                      child:    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${tr(LocaleKeys.location)}'),
                          if(officeProvider.location)
                          Icon(Icons.check,color: Theme.of(context).primaryColor,)
                        ],
                      ),
                      value: tr(LocaleKeys.location),
                      onTap:(){
                        officeProvider.location=!officeProvider.location;
                        officeProvider.price=false;
                        officeProvider.notifyListeners();
                      }
                    ),
                  PopupMenuItem(
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(tr(LocaleKeys.price)),
                          if( officeProvider.price)
                            Icon(Icons.check,color: Theme.of(context).primaryColor,)

                        ],
                      ),
                      value: tr(LocaleKeys.price),
                      onTap:(){
                        officeProvider.price=!officeProvider.price;
                        officeProvider.location=false;
                        officeProvider.notifyListeners();
                      }
                    ),
                ]),
        ],
      ),
      drawer: Drawer(
        child: BuildDrawer(),
      ),
      body: PersistentTabView(
        context,
        onItemSelected: (index) {
          controller.index = index;
          setState(() {});
          print(controller.index);
        },
        controller: controller,
        screens: screen,//[HomeView(), ChatView(), ChartView(), FavoriteView()],
        navBarStyle: NavBarStyle.style14,
        items: [
          for (int i = 0; i < _screens.length; i++)
            PersistentBottomNavBarItem(
                icon: Icon(_screens[i]['icon']),
                activeColorPrimary: ColorManager.lightGray,
                activeColorSecondary: Theme.of(context).primaryColor)
        ],
        backgroundColor: Theme.of(context).cardColor,
      ),
    );
  }
}
