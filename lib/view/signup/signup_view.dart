import 'package:flutter/material.dart';

import '../../controller/auth_controller.dart';
import 'widgets/sign_up_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController=AuthController(context: context);
    return Scaffold(
      body: SignupViewBody(authController:authController),
    );
  }
}
