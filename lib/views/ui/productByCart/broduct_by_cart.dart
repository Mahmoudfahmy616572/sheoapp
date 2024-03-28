// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sheoapp/views/shared/app_style.dart';
import 'package:sheoapp/views/ui/productByCart/component/category_btn.dart';

import '../../../model/sneakers_model.dart';
import '../../../service/helper.dart';
import 'component/custom_sized_box.dart';
import 'component/futur_builder_product_cart.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  double _value = 100;
  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;
  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFemaleSneakers();
  }

  void getKids() {
    _kids = Helper().getKidsSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.37,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/top_image.png"),
                      fit: BoxFit.fill)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              filter();
                            },
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    TabBar(
                        padding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelStyle: appstyleWithHt(
                            25, Colors.white, FontWeight.bold, 1.1),
                        labelColor: Colors.white,
                        controller: _tabController,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        isScrollable: true,
                        unselectedLabelColor: Colors.grey.withOpacity(0.3),
                        tabs: [
                          Text("Men Shoes"),
                          Text("Wemen Shoes"),
                          Text("Kids Shoes"),
                        ]),
                  ]),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: _male,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: Colors.black,
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error${snapshot.error}");
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.175,
                            left: 16,
                            right: 12),
                        child:
                            TabBarView(controller: _tabController, children: [
                          FutureBuilderProductCart(male: _male),
                          FutureBuilderProductCart(male: _female),
                          FutureBuilderProductCart(male: _kids),
                        ]),
                      );
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    return showModalBottomSheet(
        isScrollControlled: true,
        barrierColor: Colors.white54,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.84,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black38,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(children: [
                  CustomSizedBox(),
                  Text(
                    "Filter",
                    style: appstyle(40, Colors.black, FontWeight.bold),
                  ),
                  CustomSizedBox(),
                  Text(
                    "Category",
                    style: appstyle(20, Colors.black, FontWeight.bold),
                  ),
                  CustomSizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryBTN(
                        btnClr: Colors.black,
                        txt: 'shoe',
                      ),
                      CategoryBTN(
                        btnClr: Colors.grey,
                        txt: 'Athletics',
                      ),
                      CategoryBTN(
                        btnClr: Colors.grey,
                        txt: 'Collection',
                      ),
                    ],
                  ),
                  CustomSizedBox(),
                  Text(
                    "Gender",
                    style: appstyle(20, Colors.black, FontWeight.bold),
                  ),
                  CustomSizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryBTN(
                        btnClr: Colors.black,
                        txt: 'Men',
                      ),
                      CategoryBTN(
                        btnClr: Colors.grey,
                        txt: 'Women',
                      ),
                      CategoryBTN(
                        btnClr: Colors.grey,
                        txt: 'Kids',
                      ),
                    ],
                  ),
                  CustomSizedBox(),
                  Text(
                    "price",
                    style: appstyle(20, Colors.black, FontWeight.bold),
                  ),
                  CustomSizedBox(),
                  Slider(
                      value: _value,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      thumbColor: Colors.black,
                      divisions: 50,
                      secondaryTrackValue: 200,
                      label: _value.toString(),
                      max: 500,
                      onChanged: (double value) {}),
                  CustomSizedBox(),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    height: 80,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                border: Border.all(color: Colors.black)),
                            child: Image.asset(brand[index]),
                          );
                        }),
                  )
                ]),
              ),
            ]),
          );
        });
  }
}
