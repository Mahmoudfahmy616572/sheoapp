// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sheoapp/controller/favourite_list_provider.dart';
import 'package:sheoapp/controller/product_page_provider.dart';
import 'package:sheoapp/model/sneakers_model.dart';
import 'package:sheoapp/service/helper.dart';
import 'package:sheoapp/views/shared/app_style.dart';
import 'package:sheoapp/views/ui/favourite/favourite.dart';

import 'component/buttom_product_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});
  final String id;
  final String category;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isFav = false;

  final PageController _pageController = PageController();
  final _cartBox = Hive.box('Cart_box');
  final _favBox = Hive.box("Fav_box");

  late Future<Sneakers> _sneakers;
  void getSheo() {
    if (widget.category == "Men's Running") {
      _sneakers = Helper().getMaleSneakersById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneakers = Helper().getFemaleSneakersById(widget.id);
    } else {
      _sneakers = Helper().getKidsSneakersById(widget.id);
    }
  }

  Future<void> _creatCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  Future<void> _creatFav(Map<String, dynamic> newFav) async {
    await _favBox.add(newFav);
  }

  @override
  void initState() {
    super.initState();
    getSheo();
  }

  @override
  Widget build(BuildContext context) {
    var favouriteNotifier =
        Provider.of<FavouriteListProvider>(context, listen: true);
    favouriteNotifier.getFav();
    return Scaffold(
      body: FutureBuilder<Sneakers>(
          future: _sneakers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Colors.black,
              );
            } else if (snapshot.hasError) {
              return Text("Error${snapshot.error}");
            } else {
              final sneaker = snapshot.data;
              return Consumer<ProductPageProvider>(
                builder: (context, productPageProvider, child) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        leadingWidth: 0,
                        automaticallyImplyLeading: false,
                        title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    productPageProvider.shoeSizes.clear();
                                  },
                                  child: const Icon(Icons.close),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Icon(Icons.more_horiz),
                                )
                              ],
                            )),
                        pinned: false,
                        snap: false,
                        floating: true,
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        expandedHeight: MediaQuery.of(context).size.height,
                        flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.425,
                                // color:
                                child: PageView.builder(
                                    itemCount: sneaker!.imageUrl.length,
                                    controller: _pageController,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (page) {
                                      productPageProvider.activePage = page;
                                    },
                                    itemBuilder: (context, int index) {
                                      return Stack(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.39,
                                            child: Image.network(
                                              sneaker.imageUrl[index],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Positioned(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              right: 15,
                                              /////////////////////////
                                              child: Consumer<
                                                      FavouriteListProvider>(
                                                  builder: (context,
                                                      favouriteListProvider,
                                                      child) {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    if (favouriteListProvider
                                                        .ids
                                                        .contains(widget.id)) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Favourite()));
                                                    } else {
                                                      _creatFav({
                                                        "id": sneaker.id,
                                                        "price": sneaker.price,
                                                        "name": sneaker.name,
                                                        "category":
                                                            sneaker.category,
                                                        "imageUrl":
                                                            sneaker.imageUrl[0],
                                                      });
                                                      setState(() {});
                                                    }
                                                  },
                                                  child: Icon(
                                                    favouriteListProvider.ids
                                                            .contains(
                                                                sneaker.id)
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_border_outlined,
                                                    color: Colors.black,
                                                    size: 30,
                                                  ),
                                                );
                                              })
                                              /////////////////////////////
                                              ),
                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              left: 0,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children:
                                                      List<Widget>.generate(
                                                          sneaker
                                                              .imageUrl.length,
                                                          (index) => Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 5,
                                                                  backgroundColor: productPageProvider
                                                                              .activePage !=
                                                                          index
                                                                      ? Colors
                                                                          .grey
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                              )),
                                                ),
                                              )),
                                        ],
                                      );
                                    })),
                            Positioned(
                              bottom: 10,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                child: Container(
                                  color: Colors.white,
                                  height:
                                      MediaQuery.of(context).size.height * 0.62,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              sneaker.name,
                                              style: appstyleWithHt(
                                                  30,
                                                  Colors.black,
                                                  FontWeight.bold,
                                                  1),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          // Raiting Row
                                          Row(
                                            children: [
                                              Text(
                                                sneaker.category,
                                                style: appstyle(
                                                    20,
                                                    Colors.grey.shade500,
                                                    FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              RatingBar.builder(
                                                itemBuilder: ((context, _) =>
                                                    const Icon(
                                                      Icons.star,
                                                      size: 18,
                                                      color: Colors.black,
                                                    )),
                                                onRatingUpdate: (rating) {},
                                                initialRating: 4,
                                                allowHalfRating: true,
                                                itemSize: 22,
                                                minRating: 12,
                                                direction: Axis.horizontal,
                                                itemCount: 5,
                                              )
                                            ],
                                          ),
                                          //price Row
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${sneaker.price}",
                                                style: appstyle(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.w700),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "colors",
                                                    style: appstyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.black,
                                                            shape: BoxShape
                                                                .circle),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.red,
                                                            shape: BoxShape
                                                                .circle),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          //Selected Sizes Row
                                          Row(
                                            children: [
                                              Text(
                                                "Select sizes",
                                                style: appstyle(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Select sizes",
                                                style: appstyle(
                                                    20,
                                                    Colors.grey.shade400,
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          //Sizes List
                                          SizedBox(
                                            height: 40,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: productPageProvider
                                                    .shoeSizes.length,
                                                itemBuilder: (context, index) {
                                                  final sizes =
                                                      productPageProvider
                                                          .shoeSizes[index];
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 6),
                                                    child: ChoiceChip(
                                                      label: Text(
                                                        productPageProvider
                                                                .shoeSizes[
                                                            index]['size'],
                                                        style: appstyle(
                                                            18,
                                                            sizes['isSelected']
                                                                ? Colors.white
                                                                : Colors.black,
                                                            FontWeight.w500),
                                                      ),
                                                      selected:
                                                          sizes['isSelected'],
                                                      onSelected: (onselected) {
                                                        if (productPageProvider
                                                            .sizes
                                                            .contains(sizes[
                                                                'size'])) {
                                                          productPageProvider
                                                              .sizes
                                                              .remove(sizes[
                                                                  'size']);
                                                        } else {
                                                          productPageProvider
                                                              .sizes
                                                              .add(sizes[
                                                                  'size']);
                                                        }

                                                        setState(() {
                                                          productPageProvider
                                                              .toggleCheck(
                                                                  index);
                                                        });
                                                      },
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8),
                                                      selectedColor:
                                                          Colors.black,
                                                      disabledColor: Colors.grey
                                                          .withOpacity(0.4),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      side: const BorderSide(
                                                        width: 1,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          //divider
                                          const Divider(
                                            indent: 10,
                                            endIndent: 10,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          //title text
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Text(
                                              sneaker.title,
                                              style: appstyle(26, Colors.black,
                                                  FontWeight.w700),
                                            ),
                                          ),
                                          //description
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.99,
                                            child: Text(sneaker.description),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          //button Add to cart
                                          ButtomProductPage(
                                            ontap: () async {
                                              _creatCart({
                                                "id": sneaker.id,
                                                "price": sneaker.price,
                                                "name": sneaker.name,
                                                "category": sneaker.category,
                                                "imageUrl": sneaker.imageUrl[0],
                                                "sizes": productPageProvider
                                                    .sizes[0],
                                                "qty": 1
                                              });
                                              productPageProvider.sizes.clear();
                                              Navigator.pop(context);
                                            },
                                            lable: "Add to Cart",
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                      )
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}
