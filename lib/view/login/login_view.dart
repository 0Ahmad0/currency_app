import '../../controller/auth_controller.dart';
import '/view/login/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController=AuthController(context: context);
    return Scaffold(
      body: LoginViewBody(authController: authController),
    );
  }
}
