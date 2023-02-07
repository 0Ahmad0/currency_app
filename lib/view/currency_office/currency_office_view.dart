import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/office_provider.dart';
import '../../model/models.dart';
import 'widgets/currency_office_view_body.dart';

class CurrencyOfficeView extends StatelessWidget {
  final int index;
  final User office;
  const CurrencyOfficeView({super.key, required this.index, required this.office});
  @override
  Widget build(BuildContext context) {
    OfficeProvider officeProvider =Provider.of<OfficeProvider>(context);
    officeProvider.office=office;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: CurrencyOfficeViewBody(index: index,),
    );
  }
}
