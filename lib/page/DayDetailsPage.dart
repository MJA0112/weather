import 'package:weatherjavadtest/model/weathermodel.dart';
import 'package:flutter/material.dart';

class DayDEtailsPage extends StatelessWidget {
  DayDEtailsPage({
    Key? key,
    required this.weather,
  }) : super(key: key);
  final WeatherModel weather;

  late Size screensize;

  @override
  Widget build(BuildContext context) {
    screensize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisSpacing: 1,
                mainAxisSpacing: 2,
                crossAxisCount: 2,
                children: <Widget>[
                  DetailsCard_Widget(
                      screensize: screensize,
                      image: 'drop.png',
                      label: weather.Humidity),
                  DetailsCard_Widget(
                      screensize: screensize,
                      image: 'rain.png',
                      label: weather.Rain.toString()),
                  DetailsCard_Widget(
                      screensize: screensize,
                      image: 'wind.png',
                      label: weather.WindSpeed),
                  DetailsCard_Widget(
                      screensize: screensize,
                      image: 'sunrise.jpg',
                      label: weather.sunRisedt),
                  DetailsCard_Widget(
                      screensize: screensize,
                      image: 'sunset.png',
                      label: weather.sunSetdt),
                  DetailsCard_Widget(
                      screensize: screensize, image: 'temp.png', label: 'دما'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsCard_Widget extends StatelessWidget {
  const DetailsCard_Widget({
    Key? key,
    required this.screensize,
    required this.image,
    required this.label,
  }) : super(key: key);

  final Size screensize;
  final String image;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: screensize.width / 2,
      height: screensize.height / 4,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.white,
        elevation: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/$image",
              height: 100,
            ),
            Text(
              label,
              style: TextStyle(
                  color: Colors.black, fontSize: 22, fontFamily: 'vazir'),
            )
          ],
        ),
      ),
    );
  }
}
