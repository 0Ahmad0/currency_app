import 'package:flutter/material.dart';

import '../../resourse/color_manager.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({Key? key,
    this.shadowColor = ColorManager.lightGray,
    required this.child,
    this.padding = 10.0,
    this.margin = 10.0,
    this.color = ColorManager
        .white,
    this.blurRadius = 10.0,
     this.radius = 8.0
  })
      : super(key: key);
  final Color shadowColor;
  final Widget child;
  final double padding;
  final double margin;
  final double blurRadius;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
                color: shadowColor.withOpacity(.3),
                blurRadius: blurRadius,
              offset: Offset(0,4)
            ),
          ],
        borderRadius: BorderRadius.circular(radius)
      ),
      child: child,
    );
  }
}
