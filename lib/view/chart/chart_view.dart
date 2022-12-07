import 'dart:math';

import 'package:country_flags/country_flags.dart';
import 'package:currency_app/view/resourse/color_manager.dart';
import 'package:currency_app/view/resourse/values_manager.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../translations/locale_keys.g.dart';
import '../manager/widgets/ShadowContainer.dart';
import 'chart_view.dart';
import 'chart_view.dart';

class ChartView extends StatefulWidget {
   final List<FlSpot>? data;

  const ChartView({super.key, this.data});
  @override
  State<ChartView> createState() => _ChartViewState();

  static List<FlSpot> generateSampleData(){
    final List<FlSpot> result = [];
    final numPoints = 35;
    final maxY = 6;
    double prev = 0;

    for(int i = 0 ; i < numPoints ; i++)
      {
        final next = prev + Random().nextInt(3).toDouble() % -1000* i + Random().nextDouble() * maxY / 10;

        prev = next;
        result.add(
          FlSpot(i.toDouble(), next)
        );
      }
    return result;
  }
}

class _ChartViewState extends State<ChartView> {



  final toController = TextEditingController();

  var flagFrom = "SA";
  var flagTo = "US";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSize.s10,),
        ShadowContainer(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                TextFormField(
                  controller: toController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(AppPadding.p10),
                    icon: GestureDetector(
                      onTap: () {
                        showCurrencyPicker(
                            context: context,
                            onSelect: (Currency currency) {
                              flagFrom = currency.code
                                  .substring(0, currency.code.length - 1);
                              setState(() {});
                            });
                      },
                      child: CountryFlags.flag(
                        flagFrom,
                        width: 30.0,
                        height: 30.0,
                      ),
                    ),
                    hintText: tr(LocaleKeys.from),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
//              GestureDetector(
//                onTap: (){},
//                child: CircleAvatar(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//
//                      Icon(Icons.arrow_upward,size: 10.sp,),
//                      Icon(Icons.arrow_downward,size: 10.sp,),
//                    ],
//                  ),
//                ),
//              ),
//              const SizedBox(
//                height: AppSize.s10,
//              ),
                TextFormField(
                  controller: toController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(AppPadding.p10),
                    hintText: tr(LocaleKeys.to),
                    icon: GestureDetector(
                      onTap: () {
                        showCurrencyPicker(
                            context: context,
                            onSelect: (Currency currency) {
                              flagTo = currency.code
                                  .substring(0, currency.code.length - 1);
                              setState(() {});
                            });
                      },
                      child: CountryFlags.flag(
                        flagTo,
                        width: 30.0,
                        height: 30.0,
                      ),
                    ),
                  ),
                ),
              ],
            )),
        const SizedBox(height: AppSize.s10,),
        Expanded(
          child: LineChart(
            lineChartDate,
            swapAnimationDuration: Duration(milliseconds: 2500),
          ),
        ),
      ],
    );
  }

  LineChartData get lineChartDate => LineChartData(
    lineTouchData: lineTouch,
    gridData: gridDate,
    titlesData:titlesData,
    borderData:borderData,
    lineBarsData: [lineBarsData]
  );

  LineTouchData get lineTouch => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.black
    )
  );

  FlGridData get gridDate => FlGridData(
    show: false
  );

  FlBorderData get borderData => FlBorderData(
    show: false
  );

  LineChartBarData get lineBarsData => LineChartBarData(
    isCurved: true,
    color: ColorManager.lightGray,
    barWidth: 2,
    dotData: FlDotData(show: false),
    spots:  widget.data ?? ChartView.generateSampleData(),
    belowBarData: BarAreaData(
      show: true,
      color: Theme.of(context).primaryColor,

    )
  );

  FlTitlesData get titlesData => FlTitlesData();
}
