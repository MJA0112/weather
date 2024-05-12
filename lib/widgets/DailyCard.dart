import 'package:faradars_weather/model/weathermodel.dart';
import 'package:faradars_weather/page/DayDetailsPage.dart';
import 'package:flutter/material.dart';

class DailyCard extends StatelessWidget {
  const DailyCard({required this.weather, Key? key}) : super(key: key);
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DayDEtailsPage(
                      weather: weather,
                    )));
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        trailing: Text(
          weather.temp,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        title: Text(
          weather.dt,
          style: TextStyle(color: Colors.black87, fontSize: 20),
        ),
        leading: Image.network(weather.icon),
      ),
    );
  }
}
