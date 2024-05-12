import 'package:intl/intl.dart';

class HourlyModel {
  final String dt;
  final String temp;
  final String weatherstate;
  final String description;
  final String icon;

  HourlyModel(
      {required this.dt,
      required this.temp,
      required this.description,
      required this.weatherstate,
      required this.icon});

  factory HourlyModel.fromjson(Map<String, dynamic> json, int index) {
    final dt = DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
        json['hourly'][index]['dt'] * 1000,
        isUtc: true));
    final String temp =
        (json['hourly'][index]['temp'] - 273).toStringAsFixed(0);
    final String description =
        json['hourly'][index]['weather'][0]['description'];
    final String weatherstate = json['hourly'][index]['weather'][0]['main'];
    final String icon =
        'http://openweathermap.org/img/wn/${json['hourly'][index]['weather'][0]['icon']}@4x.png';
    return HourlyModel(
        dt: dt,
        temp: temp,
        description: description,
        weatherstate: weatherstate,
        icon: icon);
  }
}
