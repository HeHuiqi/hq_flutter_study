import 'package:flutter/material.dart';

class HqLocaleProvider with ChangeNotifier {
  int _localIndex = -1; //默认没有在App内设置
  int get localIndex => _localIndex;
  void setLocaleIndex(int index) {
    _localIndex = index;
    notifyListeners();
  }
}
