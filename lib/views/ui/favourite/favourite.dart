import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sheoapp/controller/favourite_list_provider.dart';

import '../../shared/app_style.dart';
import '../mainScreen/main_screen.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final _favBox = Hive.box("Fav_box");

  _deleteFav(int key) async {
    await _favBox.delete(key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var favouriteNotifier =
        Provider.of<FavouriteListProvider>(context, listen: true);
    favouriteNotifier.getFav();
    List<dynamic> favList = [];
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item["id"],
        "price": item["price"],
        "name": item["name"],
        "category": item["category"],
        "imageUrl": item["imageUrl"],
      };
    }).toList();
    favList = favData.reversed.toList();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/top_image.png"),
                        fit: BoxFit.cover)),
                child: Text(
                  "Favourites ",
                  style: appstyle(30, Colors.white, FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ListView.builder(
                    itemCount: favList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = favList[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height * .12,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                data["imageUrl"],
                                fit: BoxFit.fill,
                                width: 80,
                                height: 80,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['name'],
                                    style: appstyle(
                                        20, Colors.black, FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    data['category'],
                                    style: appstyle(
                                        16, Colors.grey, FontWeight.w700),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    "${data['price']}",
                                    style: appstyle(
                                        18, Colors.black, FontWeight.w700),
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                              Consumer<FavouriteListProvider>(builder:
                                  (context, favouriteListProvider, child) {
                                return GestureDetector(
                                    onTap: () {
                                      _deleteFav(data['key']);
                                      favouriteListProvider.ids.removeWhere(
                                          (element) => element == data['id']);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainScreen()));
                                      setState(() {});
                                    },
                                    child: const Icon(Ionicons.heart_dislike));
                              })
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          )),
    );
  }
}
