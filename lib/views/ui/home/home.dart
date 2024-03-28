// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sheoapp/model/sneakers_model.dart';
import 'package:sheoapp/service/helper.dart';
import 'package:sheoapp/views/shared/app_style.dart';
import 'package:sheoapp/views/ui/mainScreen/component/build_drawer.dart';

import 'components/home_widget.dart';

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final credential = FirebaseAuth.instance.currentUser;
  final userss = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('userSSS');
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late final TabController _tabController =
      TabController(length: 3, vsync: this);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color.fromRGBO(226, 226, 226, 1),
        drawer: BuildDrawer(
          documentId: credential!.uid,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/top_image.png"),
                      fit: BoxFit.cover)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Athletics Shoes",
                      style: appstyleWithHt(
                          42, Colors.white, FontWeight.bold, 1.5),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          "Collection",
                          style: appstyleWithHt(
                              42, Colors.white, FontWeight.bold, 1.2),
                        ),
                      ],
                    ),
                    TabBar(
                        padding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        labelColor: Colors.white,
                        isScrollable: true,
                        controller: _tabController,
                        labelStyle: appstyle(24, Colors.white, FontWeight.bold),
                        unselectedLabelColor: Colors.grey.withOpacity(0.3),
                        dividerColor: Colors.transparent,
                        tabs: const [
                          Tab(
                            text: ("Men shoes"),
                          ),
                          Tab(
                            text: ("Women Shoes"),
                          ),
                          Tab(
                            text: ("Kids Shoes"),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
            Positioned(
                left: 10,
                top: 20,
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Ionicons.menu,
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.265),
              child: Container(
                padding: EdgeInsets.only(left: 12),
                child: TabBarView(controller: _tabController, children: [
                  HomeWidget(
                    male: _male,
                    tabIndex: 0,
                  ),
                  HomeWidget(
                    male: _female,
                    tabIndex: 1,
                  ),
                  HomeWidget(
                    male: _kids,
                    tabIndex: 2,
                  ),
                ]),
              ),
            )
          ]),
        ));
  }
}
