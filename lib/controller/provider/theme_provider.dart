import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier{
  bool isDark = false;
  getApplicationTheme(){
    isDark = !isDark;
    notifyListeners();
  }
}