import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
          Spacer(),
          Icon(Icons.cast),
          kWidth,
          Container(
            height: 30,
            width: 30,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
