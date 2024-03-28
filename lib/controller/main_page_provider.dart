import 'package:flutter/material.dart';

class MainPageProvider extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageindex => _pageIndex;
  set pageindex(newindex) {
    _pageIndex = newindex;
    notifyListeners();
  }
}
