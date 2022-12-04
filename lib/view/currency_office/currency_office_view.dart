import 'package:flutter/material.dart';

import 'widgets/currency_office_view_body.dart';

class CurrencyOfficeView extends StatelessWidget {
  final int index;

  const CurrencyOfficeView({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: CurrencyOfficeViewBody(index: index,),
    );
  }
}
