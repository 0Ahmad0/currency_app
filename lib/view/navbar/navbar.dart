import 'package:currency_app/translations/locale_keys.g.dart';
import 'package:currency_app/view/chat/chat_view.dart';
import 'package:currency_app/view/favorite/favorite_view.dart';
import 'package:currency_app/view/home/home_view.dart';
import 'package:currency_app/view/navbar/widgets/build_drawer.dart';
import 'package:currency_app/view/resourse/color_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
    _screens = [
      {
        "title": tr(LocaleKeys.home_page),
        "icon": Icons.home,
        "screen": HomeView(),
      },
      {
        "title": tr(LocaleKeys.chat_page),
        "icon": Icons.chat,
        "screen": ChatView()
      },
      {
        "title": tr(LocaleKeys.rate_page),
        "icon": Icons.show_chart_rounded,
        "screen": ChartView()
      },
      {
        "title": tr(LocaleKeys.favorite_page),
        "icon": Icons.favorite,
        "screen": FavoriteView()
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[controller.index]['title']),
        actions: [
          if (controller.index == 0)
            PopupMenuButton(
                icon: Icon(
                  Icons.filter_list,
                  color: ColorManager.lightGray,
                ),
                itemBuilder: (context) => [

                    PopupMenuItem(
                      child: Text(tr(LocaleKeys.location)),
                      value: tr(LocaleKeys.location),
                    ),
                  PopupMenuItem(
                      child: Text(tr(LocaleKeys.price)),
                      value: tr(LocaleKeys.price),
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
        screens: [HomeView(), ChatView(), ChartView(), FavoriteView()],
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
