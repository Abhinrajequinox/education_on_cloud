import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:education_on_cloud/Widgets/Home/Home_Screen/home_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final HomeScreenWidgets homeScreenWidgets = HomeScreenWidgets();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
    );
  }
}

AppBar _appBar(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;

  return AppBar(
      backgroundColor:
          languageController.currentTheme.value.scaffoldBackgroundColor,
      leading: Row(children: [
        SizedBox(width: screenWidth * 0.05),
        const CircleAvatar(radius: 18),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined,
                color: Colors.black),
            iconSize: screenWidth * 0.09),
        ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                minimumSize: WidgetStateProperty.all<Size>(
                    Size(screenWidth * 0.25, 35))),
            child: CustomText(
                text: 'Subscribe Now',
                textStyle: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w800)))
      ]),
      leadingWidth: screenWidth * 0.7,
      actions: [
        Image.asset('lib/Assets/titlelogo.png', width: screenWidth * 0.25),
        SizedBox(width: screenWidth * 0.05)
      ]);
}

Widget _body() {
  return SingleChildScrollView(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        homeScreenWidgets.coursePlans(),
        homeScreenWidgets.searchCourse(),
        homeScreenWidgets.categoryAndGrid(),
        homeScreenWidgets.categoryBuilder(),
        homeScreenWidgets.ourStatisticsText(),
        homeScreenWidgets.ourStatisticsSession(),
        homeScreenWidgets.coursesBoardsAndGrid(),
    ]),
  );
}
