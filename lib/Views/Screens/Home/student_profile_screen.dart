import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _appBar(context, screenWidth),
      body: _body(screenHeight, screenWidth),
    );
  }
}

AppBar _appBar(BuildContext context, double screenWidth) {
  return AppBar(
      backgroundColor:
          languageController.currentTheme.value.scaffoldBackgroundColor,
      leading: Row(children: [
        // SizedBox(width: screenWidth * 0.05),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined,
                color: Colors.black),
            iconSize: screenWidth * 0.09),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: screenWidth * 0.08,
            width: screenWidth * 0.30,
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Center(
              child: CustomText(
                  text: 'Subscribe Now',
                  textStyle: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.w800)),
            ),
          ),
        )
      ]),
      leadingWidth: screenWidth * 0.7,
      actions: [
        Image.asset('lib/Assets/titlelogo.png', width: screenWidth * 0.25),
        SizedBox(width: screenWidth * 0.05)
      ]);
}

Widget _body(double screenHeight, screenWidth) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: const Color.fromRGBO(22, 127, 113, 1), width: 3)),
        child: ClipOval(
          child: Image.asset(
            'lib/Assets/Home/profile-image.png',
            fit: BoxFit.cover,
            width: 110, // Diameter of CircleAvatar = 2 * radius
            height: 110,
          ),
        ),
      ),
      SizedBox(height: screenHeight * .015),
      CustomText(
        text: 'Abhinraj',
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 24),
      ),
      SizedBox(height: screenHeight * .007),
      CustomText(
        text: '8592943588',
        fontWeight: FontWeight.w700,
        fontSize: 13,
        color: const Color.fromRGBO(84, 84, 84, 1),
        textStyle: GoogleFonts.inter(),
      ),
      listTileOfProfile()
    ],
  );
}

Widget listTileOfProfile() {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      children: [
        customListTileForProfile('Payment Option', Icons.wallet, () {}),
        customListTileForProfile('Product', Icons.layers_rounded, () {}),
        customListTileForProfile('About Us', Icons.info_outline_rounded, () {}),
        customListTileForProfile(
            'Privacy policy', Icons.privacy_tip_outlined, () {}),
        customListTileForProfile(
            'Select Your mode', Icons.toggle_on_outlined, () {}),
        customListTileForProfile('Log Out', Icons.logout_rounded, () {}),
      ],
    ),
  );
}

Widget customListTileForProfile(
    String title, IconData leadingIcon, void Function()? onTap) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0,top: 8),
    child: ListTile(
        onTap: onTap,
        leading: Icon(leadingIcon),
        title: CustomText(
          text: title,
          textStyle:
              GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        trailing: const Icon(Icons.arrow_forward_ios)),
  );
}
