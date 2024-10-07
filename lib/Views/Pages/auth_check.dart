import 'package:education_on_cloud/Controller/Services/Auth/login_services.dart';
import 'package:flutter/material.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({super.key});

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

final LoginServices loginServices=LoginServices();

class _AuthCheckPageState extends State<AuthCheckPage> {

  @override
  void initState() {
    super.initState();
    loginServices.checkLoginStatus(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold( body: Center(child: CircularProgressIndicator()));
  }
}