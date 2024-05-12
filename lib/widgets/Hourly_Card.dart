import 'package:weatherjavadtest/model/HourlyWeather.dart';
import 'package:flutter/material.dart';

class Hourly_Card extends StatelessWidget {
  const Hourly_Card({
    required this.hourly,
    required this.screensize,
    Key? key,
  }) : super(key: key);
  final Size screensize;
  final HourlyModel hourly;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: screensize.width / 5.5,
      height: screensize.height / 6,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff9BC6FD),
                Color(0xff5099FC),
              ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            hourly.dt,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Image.network(
            hourly.icon,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          Text(
            hourly.temp,
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
