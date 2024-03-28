import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:sheoapp/views/shared/app_style.dart';

class Cart extends StatefulWidget {
  Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _cartBox = Hive.box("Cart_box");

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item["id"],
        "price": item["price"],
        "name": item["name"],
        "category": item["category"],
        "imageUrl": item["imageUrl"],
        "sizes": item["sizes"],
        "qty": item["qty"],
      };
    }).toList();
    cart = cartData.reversed.toList();
    _deleteFav(int key) async {
      await _cartBox.delete(key);
      setState(() {});
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2E2E2),
        title: Text(
          "my Cart",
          style: appstyle(30, Colors.black, FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.67,
                  child: ListView.builder(
                      itemCount: cart.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final data = cart[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    // An action can be bigger than the others.
                                    flex: 1,
                                    onPressed: (context) {
                                      setState(() {
                                        _deleteFav(data['key']);
                                      });
                                    },
                                    backgroundColor: const Color(0xFF000000),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade500,
                                          offset: const Offset(0, 1),
                                          blurRadius: 0.3,
                                          spreadRadius: 5),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          Image.network(
                                            data['imageUrl'],
                                            fit: BoxFit.contain,
                                            width: 80,
                                            height: 80,
                                          ),
                                        ],
                                      ),
                                      // Column for (name , price , size ,category)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data["name"],
                                              style: appstyle(16, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            Text(
                                              data["category"],
                                              style: appstyle(22, Colors.grey,
                                                  FontWeight.bold),
                                            ),
                                            //Row Price & size
                                            Row(
                                              children: [
                                                Text(
                                                  "\$${data["price"]}",
                                                  style: appstyle(
                                                      20,
                                                      Colors.black,
                                                      FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                                //Size Row
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Size",
                                                      style: appstyle(
                                                          20,
                                                          Colors.black,
                                                          FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      data["sizes"].toString(),
                                                      style: appstyle(
                                                          20,
                                                          Colors.black,
                                                          FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                    Icons.add_circle),
                                              ),
                                              Text(
                                                data["qty"].toString(),
                                                style: appstyle(
                                                    12,
                                                    Colors.black,
                                                    FontWeight.bold),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                    Icons.remove_circle),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          )
        ],
      ),
    );
  }
}
