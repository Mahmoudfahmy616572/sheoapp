// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../../model/sneakers_model.dart';
import 'stagger_tile_card.dart';

class FutureBuilderProductCart extends StatelessWidget {
  const FutureBuilderProductCart({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _male,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
              color: Colors.black,
            );
          } else if (snapshot.hasError) {
            return Text("Error${snapshot.error}");
          } else {
            final male = snapshot.data;
            return StaggeredGridView.countBuilder(
              padding: EdgeInsets.all(5),
              crossAxisCount: 2,
              itemCount: male!.length,
              mainAxisSpacing: 16,
              crossAxisSpacing: 20,
              staggeredTileBuilder: ((index) => StaggeredTile.extent(
                  (index % 2 == 0) ? 1 : 1,
                  (index % 4 == 1 || index % 4 == 3)
                      ? MediaQuery.of(context).size.height * 0.35
                      : MediaQuery.of(context).size.height * 0.3)),
              itemBuilder: (BuildContext context, int index) {
                final sheo = snapshot.data![index];

                return StaggerTileCard(
                  imageUrl: sheo.imageUrl[1],
                  price: "\$${sheo.price}",
                  name: sheo.name,
                );
              },
            );
          }
        });
  }
}
