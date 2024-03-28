import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sheoapp/views/shared/app_style.dart';

class BuildDrawer extends StatefulWidget {
  const BuildDrawer({
    super.key,
    required this.documentId,
  });
  final String documentId;

  @override
  State<BuildDrawer> createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  bool isClick = false;

  @override
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Drawer(
                backgroundColor: const Color.fromARGB(255, 15, 19, 21),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.fromLTRB(20, 40, 0, 10),
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(),
                        child: SingleChildScrollView(
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${data['Name']}",
                                style:
                                    appstyle(18, Colors.white70, FontWeight.w700),
                              ),
const SizedBox(height: 5,),
                              Text(
                                " ${data['email']}",
                                maxLines: 2,
                                style:
                                    appstyle(16, Colors.white, FontWeight.w500),
                              ),
                            ],
                          ),
                        )),
                    ListTile(
                      title: const DrowerWidget(
                        txt: 'Profile',
                        myicon: Ionicons.person,
                      ),
                      onTap: () {
                        setState(() {
                          isClick = true;
                        });
                      },
                    ),
                    ListTile(
                      title: const DrowerWidget(
                        txt: 'Home',
                        myicon: Ionicons.home,
                      ),
                      onTap: () {
                        setState(() {
                          isClick = true;
                        });
                      },
                    ),
                    ListTile(
                      title: const DrowerWidget(
                        txt: 'My Cart',
                        myicon: Ionicons.bag,
                      ),
                      onTap: () {
                        setState(() {});
                      },
                    ),
                    ListTile(
                      title: const DrowerWidget(
                        txt: 'Favourite',
                        myicon: Ionicons.heart,
                      ),
                      onTap: () {
                        setState(() {
                          isClick = true;
                        });
                      },
                    ),
                    ListTile(
                      title: const DrowerWidget(
                        txt: 'Order',
                        myicon: Icons.library_books_outlined,
                      ),
                      onTap: () {
                        setState(() {});
                      },
                    ),
                    ListTile(
                      hoverColor: Colors.red,
                      enabled: true,
                      title: const DrowerWidget(
                        txt: 'Notifications',
                        myicon: Ionicons.notifications,
                      ),
                      onTap: () {
                        setState(() {});
                      },
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.5,
                      endIndent: 15,
                      indent: 15,
                    ),
                    ListTile(
                      hoverColor: Colors.red,
                      enabled: true,
                      title: const DrowerWidget(
                        txt: 'Log out',
                        myicon: Ionicons.log_out,
                      ),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return const Text("loading");
        });
  }
}

class DrowerWidget extends StatelessWidget {
  const DrowerWidget({
    super.key,
    required this.txt,
    required this.myicon,
  });
  final String txt;
  final IconData myicon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.transparent),
      child: Row(
        children: [
          Icon(
            myicon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            txt,
            style: appstyle(18, Colors.white, FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
