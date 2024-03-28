// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sheoapp/views/shared/app_style.dart';

class StaggerTileCard extends StatefulWidget {
  const StaggerTileCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
  });
  final String imageUrl;
  final String name;
  final String price;

  @override
  State<StaggerTileCard> createState() => _StaggerTileCardState();
}

class _StaggerTileCardState extends State<StaggerTileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.imageUrl,
                  fit: BoxFit.fill,
                ),
                Container(
                  padding: EdgeInsets.only(top: 12),
                  height: 90,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: appstyleWithHt(
                              20, Colors.black, FontWeight.w700, 1),
                        ),
                        Text(
                          widget.price,
                          style: appstyleWithHt(
                              20, Colors.black, FontWeight.w500, 0),
                        ),
                      ]),
                )
              ]),
        ));
  }
}
