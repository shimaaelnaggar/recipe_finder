import 'package:flutter/material.dart';

class MealImage extends StatelessWidget {
  final String image;

  const MealImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          image,
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        /// Gradient overlay
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withAlpha(6), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
