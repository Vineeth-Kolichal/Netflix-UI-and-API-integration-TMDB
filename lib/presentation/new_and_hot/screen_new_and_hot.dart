// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix/presentation/new_and_hot/widgets/everyones_watching.dart';
import 'package:netflix/presentation/widgets/custom_app_bar.dart';

class ScreenNewAndHot extends StatelessWidget {
  ScreenNewAndHot({super.key});
  //TabController controller = TabController(length: 3, vsync: );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: CustomAppBar(
            leading: Text(
              'New & Hot',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            bottom: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TabBar(
                  //isScrollable: true,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  labelColor: kTextColorBlack,
                  unselectedLabelColor: kWhiteColor,
                  indicator: BoxDecoration(
                    borderRadius: kborderRadius30,
                    color: kWhiteColor,
                  ),
                  tabs: [
                    Tab(
                      height: 34,
                      text: '🍿Coming Soon',
                    ),
                    Tab(
                      height: 34,
                      text: "👀Everyone's watching",
                    ),
                  ]),
            ),
          ),
        ),
        body: TabBarView(children: [
          ComingSoonWidget(),
          EveryonesWatching(),
        ]),
      ),
    );
  }
}
