import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'controller/home_controller.dart';

class Test extends StatefulWidget {
  const Test({Key? key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  HomeController controller = Get.put(HomeController());

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter chart'),
      ),
      body: Column(
        children: [
          //Initialize the chart widget
          AspectRatio(
            aspectRatio: 1.7,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: controller.resultList.length - 1,
                minY: controller.resultList
                        .map((tempData) => tempData.temp)
                        .reduce(
                            (min, current) => min < current ? min : current) -
                    5,
                maxY: controller.resultList
                        .map((tempData) => tempData.temp)
                        .reduce(
                            (max, current) => max > current ? max : current) +
                    5,
                titlesData: FlTitlesData(
                  show: true,
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: controller.resultList
                        .asMap()
                        .map((index, tempData) => MapEntry(
                            index, FlSpot(index.toDouble(), tempData.temp)))
                        .values
                        .toList(),
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              //Initialize the spark charts widget
              child: SfSparkLineChart.custom(
                //Enable the trackball
                trackball: SparkChartTrackball(
                  activationMode: SparkChartActivationMode.tap,
                ),
                //Enable marker
                marker: SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all,
                ),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (int index) => data[index].year,
                yValueMapper: (int index) => data[index].sales,
                dataCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
