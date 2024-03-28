import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sheoapp/views/shared/app_style.dart';
import 'package:sheoapp/views/ui/favourite/favourite.dart';

import '../../../../controller/favourite_list_provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.name,
      required this.category,
      required this.price,
      required this.id,
      required this.imageUrl,
      required this.ontap});
  final String name;
  final String category;
  final String price;
  final String id;
  final String imageUrl;
  final void Function()? ontap;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final _favBox = Hive.box("Fav_box");
  Future<void> _creatFav(Map<String, dynamic> newFav) async {
    await _favBox.add(newFav);
  }

  @override
  Widget build(BuildContext context) {
    var favouriteNotifier =
        Provider.of<FavouriteListProvider>(context, listen: true);
    favouriteNotifier.getFav();
    bool selected = true;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 0.6,
                      color: Colors.white,
                      spreadRadius: 1)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.23,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                widget.imageUrl,
                              ),
                              fit: BoxFit.contain)),
                    ),
                    Positioned(
                        top: 10,
                        right: 10,
                        child: Consumer<FavouriteListProvider>(
                            builder: (context, favouriteListProvider, child) {
                          return GestureDetector(
                              onTap: () {
                                if (favouriteListProvider.ids
                                    .contains(widget.id)) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (contex) =>
                                              const Favourite()));
                                } else {
                                  _creatFav({
                                    "id": widget.id,
                                    "name": widget.name,
                                    "category": widget.category,
                                    "price": widget.price,
                                    "imageUrl": widget.imageUrl,
                                  });
                                }
                                setState(() {});
                              },
                              child: favouriteListProvider.ids
                                      .contains(widget.id)
                                  ? const Icon(Icons.favorite_rounded)
                                  : const Icon(Icons.favorite_border_outlined));
                        }))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: appstyleWithHt(
                              36, Colors.black, FontWeight.bold, 1.1),
                        ),
                        Text(
                          widget.category,
                          style: appstyleWithHt(
                              18, Colors.grey, FontWeight.bold, 1.5),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.price,
                          style: appstyleWithHt(
                              20, Colors.black, FontWeight.bold, 1.5)),
                      Row(
                        children: [
                          Text(
                            "Color",
                            style: appstyle(18, Colors.grey, FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 5,
                          ),

                          ChoiceChip(
                            label: const Text(""),
                            padding: const EdgeInsets.symmetric(
                              vertical: 9,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            selected: selected,
                            visualDensity: VisualDensity.compact,
                            selectedColor: Colors.black,
                          ),
                          // Container(
                          //   width: 30,
                          //   height: 30,
                          //   decoration: BoxDecoration(
                          //       color: Colors.black, shape: BoxShape.circle),
                          // )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
