import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final int rating;
  const StarRatingWidget({
    super.key,
    required this.rating,
  }) : assert(rating <= 5 && rating % 1 == 0);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
          (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Icon(
                Icons.star,
                color: index >= rating ? Colors.white : Colors.blue,
                size: 18,
              ),
            );
          },
        ),
      ),
    );
  }
}
