import 'package:flutter/material.dart';
import '/view/resourse/color_manager.dart';
import 'package:sizer/sizer.dart';

class ButtonApp extends StatelessWidget {
  const ButtonApp({Key? key,
     this.color = ColorManager.primaryColor,
    required this.text,
     this.radius = 12.0,
    required this.onPressed, this.textColor = ColorManager.white,
  }) : super(key: key);
  final Color? color;
  final Color? textColor;
  final String text;
  final double? radius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!)
        )
      ),
      onPressed: onPressed,
      child: Text(text,style: TextStyle(
        color: textColor,
      ),),
    );
  }
}
