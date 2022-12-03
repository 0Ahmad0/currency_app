import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../resourse/style_manager.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
      this.onTap,
      required this.title,
       this.subtitle,
      required this.icon})
      : super(key: key);
  final VoidCallback? onTap;
  final String title;
  final String? subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap ?? null,
      title: Text(title),
      subtitle: subtitle == null?null:Text(subtitle!),
      leading: Icon(icon,size: 15.sp,),
    );
  }
}
