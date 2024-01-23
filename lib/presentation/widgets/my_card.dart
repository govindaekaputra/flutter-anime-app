import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyCard extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;
  double? width;

  MyCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Column(
          children: [
            Expanded(
              child: Image.network(image),
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
