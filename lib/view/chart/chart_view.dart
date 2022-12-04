import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartView extends StatelessWidget {
   final List<FlSpot>? data;

  const ChartView({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    return LineChart(
      lineChartDate,
      swapAnimationDuration: Duration(milliseconds: 500),
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
    color: Colors.blueAccent,
    barWidth: 2,
    dotData: FlDotData(show: false),
    spots:  data ?? ChartView.generateSampleData(),
    belowBarData: BarAreaData(
      show: true,
      color: Colors.green,

    )
  );

  FlTitlesData get titlesData => FlTitlesData();

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
