import 'package:flutter/material.dart';

import 'package:midterm_01/models/models.dart';

class ClothesItem extends StatelessWidget {
  final Clothes clothes;

  const ClothesItem({
    Key? key,
    required this.clothes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/clothes_placeholder.png',
            image: clothes.imageUrl,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 3,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${clothes.name}',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Price: ${clothes.price}',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      );
}
