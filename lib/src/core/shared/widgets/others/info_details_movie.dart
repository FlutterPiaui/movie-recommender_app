import 'dart:ui';

import 'package:flutter/material.dart';

class InfoDetailsMovie extends StatelessWidget {
  final String? textInfo;
  const InfoDetailsMovie({super.key, required this.textInfo});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 150.0, sigmaY: 150.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue.withOpacity(0.5),
              width: 2.5,
            ),
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.transparent,
          ),
          child: Text(
            textInfo!,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.blue,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
