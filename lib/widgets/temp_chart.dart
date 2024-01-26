import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../controller/home_controller.dart';

class TempChart extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Widget leftTitleWidgets(double value, TitleMeta meta) {
      const style = TextStyle(
        color: Colors.white,
        fontSize: 10,
      );

      return Text('$value°C', style: style, textAlign: TextAlign.left);
    }

    Widget bottomTitleWidgets(double value, TitleMeta meta) {
      const style = TextStyle(
        fontSize: 10,
        color: Colors.white,
      );
      int index = value.toInt();
      String text = index >= 0 && index < controller.resultList.length
          ? controller.resultList[index].day
          : '';

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(text, style: style),
      );
    }

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: controller.resultList.length - 1,
        minY: controller.resultList
                .map((tempData) => tempData.temp)
                .reduce((min, current) => min < current ? min : current) -
            3,
        maxY: controller.resultList
                .map((tempData) => tempData.temp)
                .reduce((max, current) => max > current ? max : current) +
            2,
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 35,
              interval: 1,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: controller.resultList
                .asMap()
                .map((index, tempData) =>
                    MapEntry(index, FlSpot(index.toDouble(), tempData.temp)))
                .values
                .toList(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            dotData: FlDotData(show: true),
            isStrokeCapRound: false,
            belowBarData: BarAreaData(
              show: true,
            ),
          ),
        ],
      ),
    );
  }
}
