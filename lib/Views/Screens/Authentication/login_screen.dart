// import 'package:education_on_cloud/Views/Screens/Authentication/signupscreen.dart';
// import 'package:education_on_cloud/Widgets/Auth/authwidget.dart';
// import 'package:education_on_cloud/Widgets/Auth/login_screen_widget.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// final LoginScreenWidget loginScreenWidget = LoginScreenWidget();
// final TextEditingController _phoneController = TextEditingController();
// final TextEditingController _nameController = TextEditingController();
// final _formKey = GlobalKey<FormState>();

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: _body(screenHeight, screenWidth, context),
//     );
//   }
// }

// Widget _body(double screenHeight, screenWidth, BuildContext context) {
//   return Padding(
//     padding: EdgeInsets.all(screenWidth * 0.04),
//     child: Form(
//       key: _formKey,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Logo Image
//             loginScreenWidget.logoImage(screenHeight, screenWidth),
//             // Name TextForm Feild
//             CustomTextFeild(
//                 textCapitalization: TextCapitalization.none,
//                 text: 'Enter Your Name',
//                 iconData: Icons.mail_outline_rounded,
//                 controller: _nameController,
//                 keybordtype: TextInputType.name,
//                 validator: validationAuth.validateforname),
//             // Phone number TextForm Feild
//             CustomTextFeild(
//                 textCapitalization: TextCapitalization.none,
//                 text: 'Enter Your Phone number',
//                 keybordtype: TextInputType.phone,
//                 iconData: Icons.phone_outlined,
//                 validator: validationAuth.validatePhoneNumber,
//                 controller: _phoneController),
//             SizedBox(height: screenHeight * 0.02),
//             // Login Button
//             loginScreenWidget.customLoginButton(
//                 screenWidth: screenWidth,
//                 formKey: _formKey,
//                 context: context,
//                 name: _nameController.text,
//                 phoneController: _phoneController),
//             const SizedBox(height: 20),
//             // New User Text
//             loginScreenWidget.newUserAccount(context)
//           ],
//         ),
//       ),
//     ),
//   );
// }
