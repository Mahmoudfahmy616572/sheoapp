import 'package:flutter/material.dart';

class ProductPageProvider extends ChangeNotifier {
  int _activePage = 0;
  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];

  //_activePage provider
  int get activePage => _activePage;
  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  //_shoeSizes provider
  List<dynamic> get shoeSizes => _shoeSizes;
  set shoeSizes(List<dynamic> newList) {
    _shoeSizes = newList;
    notifyListeners();
  }

  //function to Check selecte sizes or not
  void toggleCheck(int index) {
    for (int i = 0; i < _shoeSizes.length; i++) {
      if (i == index) {
        _shoeSizes[i]["isSelected"] = !_shoeSizes[i]["isSelected"];
      }
    }
  }

  //_sizes Provider
  List<String> get sizes => _sizes;
  set(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }
}
