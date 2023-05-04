import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';

class DescriptionTextWidget extends StatelessWidget {
  const DescriptionTextWidget({
    super.key,
    required this.description,
    required this.title,
  });
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight,
        Text(
          description,
          style: const TextStyle(fontSize: 16, color: Colors.white60),
        ),
      ],
    );
  }
}
