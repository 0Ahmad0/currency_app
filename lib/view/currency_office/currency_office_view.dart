import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/office_provider.dart';
import 'widgets/currency_office_view_body.dart';

class CurrencyOfficeView extends StatelessWidget {
  final int index;

  const CurrencyOfficeView({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    OfficeProvider officeProvider=Provider.of<OfficeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: CurrencyOfficeViewBody(index: index,),
    );
  }
}
