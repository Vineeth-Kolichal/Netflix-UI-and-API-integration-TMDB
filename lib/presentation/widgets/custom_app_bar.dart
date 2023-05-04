import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';

class CustomAppBar extends StatelessWidget {
  final Widget leading;
  const CustomAppBar({super.key, required this.leading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          leading,
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
