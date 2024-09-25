import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _signUpBody(),
    );
  }
}

// AppBar _signUpAppbar() {
//   return AppBar();
// }

Widget _signUpBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 97),
        child: SizedBox(
          height: 90,
          width: 184.29,
          child: Image.asset('lib/Assets/titlelogo.png'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16.65, 6.47, 16.65, 6.47),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Enter Your Name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 1))),
        ),
      )
    ],
  );
}
