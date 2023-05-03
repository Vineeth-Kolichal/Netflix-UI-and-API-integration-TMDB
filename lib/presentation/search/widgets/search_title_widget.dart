import 'package:flutter/material.dart';

class SearchTitileWidget extends StatelessWidget {
  const SearchTitileWidget({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
