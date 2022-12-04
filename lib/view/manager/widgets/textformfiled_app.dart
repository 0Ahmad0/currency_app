import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class TextFiledApp extends StatefulWidget {
   TextFiledApp({Key? key,
     this.textInputAction = TextInputAction.next,
     this.keyboardType = TextInputType.text,
    this.controller,
    required this.iconData,
    required this.hintText,
    this.obscureText = false,
     this.suffixIcon = false,
      this.validator,
      this.onChanged,
      this.onTap,
      this.autofocus = false,
      this.readOnly = false
  }) : super(key: key);

  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final IconData iconData;
  final String hintText;
  final bool suffixIcon;
  final bool autofocus;
  final bool readOnly;
  bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final VoidCallback? onTap;


  @override
  State<TextFiledApp> createState() => _TextFiledAppState(

  );
}

class _TextFiledAppState extends State<TextFiledApp> {

  void showPassword(){
    setState((){
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      validator: widget.validator??(String? val){
        if(val!.trim().isEmpty) return tr(LocaleKeys.field_required);
        return null;
      },
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      style: TextStyle(
          fontSize: SizerUtil.width / 30
      ),
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        hintStyle: TextStyle(
            fontSize: SizerUtil.width / 32
        ),
          prefixIcon: Icon(widget.iconData
            , size: SizerUtil.width / 24,
          ),
          suffixIcon: widget.suffixIcon?IconButton(
            icon: Icon(!widget.obscureText?Icons.visibility:Icons.visibility_off_sharp,
              size: SizerUtil.width / 24,
            ),
            onPressed: (){
              showPassword();
            },
          ):null,
          hintText: widget.hintText
      ),
    );
  }
}
