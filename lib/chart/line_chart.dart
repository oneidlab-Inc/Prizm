import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'line_chart_data.dart';

class LineChartContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return LineChart(
        LineChartData(
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              getDrawingHorizontalLine: (value) {
                return FlLine(
                    color: isDarkMode ? Colors.grey : Colors.black12,
                    strokeWidth: 1
                );
              },
              drawVerticalLine: false,
            ),
            minX: 1,
            minY: -15,
            maxX: 10,
            maxY: 1000,
            lineBarsData: lineChartBarData,
            titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                ),
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)
                )
            ),
            lineTouchData: LineTouchData(
              // enabled: true
            )
        ));
  }
}