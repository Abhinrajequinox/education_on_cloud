import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Views/Screens/Classroom/class_room_screen.dart';
import 'package:education_on_cloud/Views/Screens/Home/home_screen.dart';
import 'package:education_on_cloud/Views/Screens/Profile/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  State<HomeBottomNavigationBar> createState() =>
      _HomeBottomNavigationBarState();
}

int _currentIntext = 0;
List<Widget> _screens = [
  const HomeScreen(),
  const ClassRoomScreen(),
  const ProfileScreen()
];

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  void onTabTaped(int indext) {
    setState(() {
      _currentIntext = indext;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_currentIntext],
        bottomNavigationBar: bottomNaviagtionBar(onTabTaped));
  }
}

Widget bottomNaviagtionBar(void Function(int) onTabTaped) {
  return Container(
      color: Colors.transparent,
      width: 360,
      height: 78,
      child: BottomNavigationBar(
          backgroundColor:
              languageController.currentTheme.value.scaffoldBackgroundColor,
          onTap: onTabTaped,
          currentIndex: _currentIntext,
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage('lib/Assets/Icons/home-icon-black.png'),
                    size: 30),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage('lib/Assets/Icons/book-icon-black.png'),
                    size: 30),
                label: 'Class Room'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage('lib/Assets/Icons/chat-bot-icon.png'),
                    size: 30),
                label: 'Krish'),
          ]));
}
