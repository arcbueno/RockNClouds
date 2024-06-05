import 'package:flutter/material.dart';
import 'package:rock_n_clouds/models/weather_domain/weather_domain.dart';
import 'package:rock_n_clouds/utils/datetime_utils.dart';

class WeatherListTile extends StatelessWidget {
  final WeatherDomain weather;

  const WeatherListTile({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(weather.areaName?.toString() ?? ''),
      subtitle: Text(DateTimeUtils.dateTimeFormat.format(weather.date!)),
      trailing: Text(
        '${weather.temperature?.celsius?.toInt()}°C',
        style: const TextStyle(fontSize: 28),
      ),
    );
  }
}
