import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/service/home_bindings.dart';

import '../controller/home_controller.dart';

class MyCard extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          controller.currentWeatherData.name.toString(),
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
        Text(
          DateFormat.yMMMd().format(DateTime.now()),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white),
        ),
        Text(
          '${(controller.currentWeatherData.main!.temp! - 273.15).round().toString()}\u2103',
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white),
        ),
        Text(
          '${controller.currentWeatherData.weather?[0].description}',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
        SizedBox(height: 10),
        Text(
          'min:${(controller.currentWeatherData.main!.tempMin! - 273.15).round().toString()}\u2103 / max:${(controller.currentWeatherData.main!.tempMax! - 273.15).round().toString()}\u2103 ',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        )
      ]),
    );
  }
}
