import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/auth_provider.dart';
import 'widgets/add_office_view_body.dart';

class AddOfficeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider= Provider.of<AuthProvider>(context);
    return Scaffold(
      body: AddOfficeViewBody(authProvider: authProvider),
    );
  }
}
