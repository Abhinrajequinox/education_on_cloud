import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  State<HomeBottomNavigationBar> createState() => _HomeBottomNavigationBarState();
}
final intext=0;
class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNaviagtionBar(),
    );
  }
}

Widget bottomNaviagtionBar() {
  return Container(
      width: 360,
      height: 78,
      child: BottomNavigationBar(currentIndex: intext,
        items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('lib/Assets/Icons/home-icon-black.png'),
              size: 30),
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/Assets/Icons/book-icon-black.png'),
                size: 30),
            label: 'Class Room'),
        BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage('lib/Assets/Icons/person-icon-black.png'),
                size: 30),
            label: 'Krish'),
      ]));
}
