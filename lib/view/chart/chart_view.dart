import 'dart:math';

import 'package:country_flags/country_flags.dart';
import 'package:currency_app/view/resourse/color_manager.dart';
import 'package:currency_app/view/resourse/values_manager.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/currency_provider.dart';
import '../../model/models.dart';
import '../../model/utils/const.dart';
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
  final fromController = TextEditingController();
  List<FlSpot> data=[];
  var flagFrom = "SA";
  var currencyForm = "SAR";
  var currencyTo = "USD";
  var flagTo = "US";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSize.s10,),
        ChangeNotifierProvider<CurrencyProvider>.value(
            value:Provider.of<CurrencyProvider>(context),
            child: Consumer<CurrencyProvider>(
                builder: (context,currencyProvider , child){
                  return ListBody(
                    children: [
                      ShadowContainer(
                          color: Theme.of(context).cardColor,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: fromController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(AppPadding.p10),
                                  icon: GestureDetector(
                                    onTap: () {
                                      showCurrencyPicker(
                                          context: context,
                                          onSelect: (Currency currency) {
                                            flagFrom = currency.code
                                                .substring(0, currency.code.length - 1);
                                            currencyForm=currency.code;
                                            currencyProvider.notifyListeners();
                                            // currencyProvider.currencyConvert.convert=Convert(from: flagFrom, to: to, amount: amount)
                                            // setState(() {});
                                          });
                                    },
                                    child: CountryFlags.flag(
                                      flagFrom,
                                      width: 30.0,
                                      height: 30.0,
                                    ),
                                  ),
                                  hintText: currencyProvider.waitFrom?tr(LocaleKeys.loading):tr(LocaleKeys.from),
                                ),onFieldSubmitted: (val) async {
                                currencyProvider.currencyConvert.convert=
                                    Convert(from: currencyForm, to: currencyTo, amount: double.parse(fromController.text));
                                currencyProvider.waitTo=true;
                                toController.text='';
                                currencyProvider.notifyListeners();
                                final result =await currencyProvider.convertCurrency(context, currencyConvert: currencyProvider.currencyConvert);
                                if(result['status']){
                                  toController.text='${currencyProvider.currencyConvert.result}';
                                }
                                print('result ${ toController.text}');
                                currencyProvider.notifyListeners();
                              },
                              ),
                              const SizedBox(
                                height: AppSize.s10,
                              ),
                              TextFormField(
                                controller: toController,
                                decoration: InputDecoration(

                                  contentPadding: EdgeInsets.all(AppPadding.p10),
                                  hintText: currencyProvider.waitTo?tr(LocaleKeys.loading):tr(LocaleKeys.to),
                                  icon: GestureDetector(
                                    onTap: () {
                                      showCurrencyPicker(
                                          context: context,
                                          onSelect: (Currency currency) {
                                            flagTo = currency.code
                                                .substring(0, currency.code.length - 1);
                                            currencyTo=currency.code;
                                            currencyProvider.notifyListeners();
                                            //setState(() {});
                                          });
                                    },
                                    child: CountryFlags.flag(
                                      flagTo,
                                      width: 30.0,
                                      height: 30.0,
                                    ),
                                  ),
                                ),
                                onFieldSubmitted: (val) async {
                                  currencyProvider.currencyConvert.convert=
                                      Convert(from: currencyTo, to: currencyForm, amount: double.parse(toController.text));
                                  currencyProvider.waitFrom=true;
                                  fromController.text='';
                                  currencyProvider.notifyListeners();

                                  final result =await currencyProvider.convertCurrency(context, currencyConvert: currencyProvider.currencyConvert);
                                  if(result['status']){
                                    fromController.text='${currencyProvider.currencyConvert.result}';
                                  }
                                  print('result ${ fromController.text}');
                                  currencyProvider.notifyListeners();

                                },
                              ),
                            ],
                          )),

                      // Text("${tr(LocaleKeys.total_amount)} 90.SR"),
                    ],
                  );

                })),
        const SizedBox(height: AppSize.s10,),
        Expanded(
          child:
    ChangeNotifierProvider<CurrencyProvider>.value(
    value:Provider.of<CurrencyProvider>(context),
    child: Consumer<CurrencyProvider>(
    builder: (context,currencyProvider , child){
      currencyProvider.convert=Convert(from: currencyForm, to: currencyTo, amount: 0);
      return  FutureBuilder(
        //prints the messages to the screen0
          future: currencyProvider.timeFrameCurrency(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return
                (currencyProvider.timeFrame.chart.keys.length>0)?
                buildLineChart(context):
                Const.SHOWLOADINGINDECATOR();
              ///waitListCategory(context);
            }
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              Const.SHOWLOADINGINDECATOR();
              generateDataChart(currencyProvider.timeFrame);
              //print("aaa ${officeProvider.price} ${officeProvider.location}");
              return buildLineChart(context);
              /// }));
            } else {
              return const Text('Empty data');
            }

          });
    }))
        ),
      ],
    );
  }
  buildLineChart(BuildContext context){
    return  LineChart(
      lineChartDate,
      swapAnimationDuration: Duration(milliseconds: 2500),
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
    spots:  widget.data ?? data,//ChartView.generateSampleData(),
    belowBarData: BarAreaData(
      show: true,
      color: Theme.of(context).primaryColor,

    )
  );

  FlTitlesData get titlesData => FlTitlesData();
  generateDataChart(TimeFrame timeFrame){
    data = [];
    for(String key in timeFrame.chart.keys)
    {
      double m=double.parse('${key.substring(5,7)}');
      double d=double.parse('${key.substring(8,10)}');
      double x=double.parse('${key.substring(5,7)}${key.substring(8,10)}');
      data.add(
          FlSpot(x, timeFrame.chart[key])
      );
    }
    return data;
  }
}
