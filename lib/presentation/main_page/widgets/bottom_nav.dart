import 'package:flutter/material.dart';

ValueNotifier<int> indexChangedNotifier = ValueNotifier(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: indexChangedNotifier,
        builder: (BuildContext ctx, int index, _) {
          return BottomNavigationBar(
              selectedFontSize: 10,
              unselectedFontSize: 10,
              onTap: (index) {
                indexChangedNotifier.value = index;
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: index,
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              selectedIconTheme: const IconThemeData(
                color: Colors.white,
              ),
              unselectedIconTheme: const IconThemeData(color: Colors.grey),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.collections),
                  label: 'New and Hot',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_emotions),
                  label: 'Fast Laughs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_circle_down_outlined),
                  label: 'Downloads',
                ),
              ]);
        });
  }
}
