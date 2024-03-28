// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheoapp/controller/product_page_provider.dart';

import '../../../../model/sneakers_model.dart';
import '../../../shared/app_style.dart';
import '../../productByCart/broduct_by_cart.dart';
import '../../productPage/prouduct_page.dart';
import 'new_shoes.dart';
import 'product_card.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> male,
    required this.tabIndex,
  }) : _male = male;

  final Future<List<Sneakers>> _male;
  final int tabIndex;

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ProductByCart(
        tabIndex: tabIndex,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 2.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var productPageProvider = Provider.of<ProductPageProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.46,
              child: FutureBuilder(
                future: _male,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      color: Colors.grey,
                    );
                  } else if (snapshot.hasError) {
                    return (Text("Error ${snapshot.error}"));
                  } else {
                    final male = snapshot.data;
                    return ListView.builder(
                        itemCount: male!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final sheo = snapshot.data![index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                productPageProvider.shoeSizes = sheo.sizes;

                                Route createRoute() {
                                  return PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ProductPage(
                                            id: sheo.id,
                                            category: sheo.category),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(2.0, 0.0);
                                      const end = Offset.zero;
                                      final tween =
                                          Tween(begin: begin, end: end);
                                      final offsetAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  );
                                }

                                Navigator.of(context).push(createRoute());
                              },
                              child: ProductCard(
                                imageUrl: sheo.imageUrl[0],
                                category: sheo.category,
                                price: "\$${sheo.price}",
                                id: sheo.id,
                                name: sheo.name,
                                ontap: () async {},
                              ),
                            ),
                          );
                        });
                  }
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Latest Shoes",
                style: appstyle(24, Colors.black, FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ProductByCart(
                  //               tabIndex: tabIndex,
                  //             )));
                  Navigator.of(context).push(_createRoute());
                },
                child: Row(
                  children: [
                    Text(
                      "Show all",
                      style: appstyle(18, Colors.black, FontWeight.normal),
                    ),
                    Icon(
                      Icons.arrow_right,
                      size: 35,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              child: FutureBuilder(
                future: _male,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      color: Colors.grey,
                    );
                  } else if (snapshot.hasError) {
                    return (Text("Error ${snapshot.error}"));
                  } else {
                    final male = snapshot.data;
                    return ListView.builder(
                        itemCount: male!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final sheo = snapshot.data![index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NewShoes(imageUrl: sheo.imageUrl[1]),
                          );
                        });
                  }
                },
              )),
        ],
      ),
    );
  }
}
