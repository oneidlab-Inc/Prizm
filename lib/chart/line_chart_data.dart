import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Color> lineColor = [
  // Color(0xfff3f169),
];

List<LineChartBarData> lineChartBarData = [
  LineChartBarData(
      color: const Color.fromRGBO(51, 211, 180, 1),
      isCurved: false,
      barWidth: 3,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(

        show: true,
        color: const Color.fromRGBO(51, 211, 180, 1).withOpacity(0.2),
      ),
      spots: [
        const FlSpot(1, 0),
        const FlSpot(2, 210),
        const FlSpot(3, 390),
        const FlSpot(4, 508),
        const FlSpot(5, 448),
        const FlSpot(6, 241),
        const FlSpot(7, 460),
        const FlSpot(8, 690),
        const FlSpot(9, 540),
        const FlSpot(10, 0),
        // FlSpot(0, double.parse(yParam[0])),
        // FlSpot(1, double.parse(yParam[1])),
        // FlSpot(2, double.parse(yParam[2])),
        // FlSpot(3, double.parse(yParam[3])),
        // FlSpot(4, double.parse(yParam[4])),
        // FlSpot(5, double.parse(yParam[5])),
        // FlSpot(6, double.parse(yParam[6])),
        // FlSpot(7, double.parse(yParam[7])),
        // FlSpot(8, double.parse(yParam[8])),
        // FlSpot(9, double.parse(yParam[9])),
        // FlSpot(10, double.parse(yParam[10])),
        // FlSpot(11, double.parse(yParam[11])),
        // FlSpot(12, double.parse(yParam[12])),
      ])
];
