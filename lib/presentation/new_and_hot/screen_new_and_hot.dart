import 'package:flutter/material.dart';
import 'package:netflix/presentation/widgets/custom_app_bar.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(
              leading: Text('New & Hot',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700))),
          preferredSize: Size.fromHeight(50)),
      body: Text('ScreenNewAndHot'),
    );
  }
}
