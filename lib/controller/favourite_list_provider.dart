import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class FavouriteListProvider extends ChangeNotifier {
  List<dynamic> _favor = [];
  List<dynamic> _ids = [];
  final _favBox = Hive.box("Fav_box");

  //_favor List
  List<dynamic> get favor => _favor;
  set favorList(List<dynamic> newFavour) {
    _favor = newFavour;
    notifyListeners();
  }

//_ids List
  List<dynamic> get ids => _ids;
  set idsList(List<dynamic> newIds) {
    _favor = newIds;
    notifyListeners();
  }

  // Future<void> _creatFav(Map<String, dynamic> newFav) async {
  //   await _favBox.add(newFav);
  //   getFav();
  // }

  getFav() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {"key": key, "id": item['id']};
    }).toList();

    _favor = favData.toList();
    _ids = _favor.map((item) => item['id']).toList();
  }
}
