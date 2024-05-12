import 'dart:async';
import 'dart:convert';
import 'package:weatherjavadtest/model/HourlyWeather.dart';
import 'package:weatherjavadtest/model/weathermodel.dart';
import 'package:weatherjavadtest/widgets/DailyCard.dart';
import 'package:weatherjavadtest/widgets/Hourly_Card.dart';
import 'package:weatherjavadtest/widgets/TitleTextWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.weather,
    required this.hourlyweather,
    required this.dailyweather,
  }) : super(key: key);
  final WeatherModel weather;
  final List<HourlyModel> hourlyweather;
  final List<WeatherModel> dailyweather;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  late Size screensize;
  @override
  Widget build(BuildContext context) {
    screensize = MediaQuery.of(context).size;
    print(widget.dailyweather[1].sunSetdt);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              width: screensize.width,
              height: screensize.height / 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff9BC6FD),
                        Color(0xff5099FC),
                      ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tomorrow",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        widget.weather.dt,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.network(
                        widget.weather.icon,
                        height: 100,
                      ),
                      Column(
                        children: [
                          Text(
                            widget.weather.temp,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "7-sunny",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                              ),
                              text: "17",
                              children: [
                            TextSpan(
                              text: "  °C",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 35,
                              ),
                            )
                          ]))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cardwidget(
                        image: "assets/wind.png",
                        label: widget.weather.WindSpeed,
                      ),
                      cardwidget(
                        image: "assets/drop.png",
                        label: widget.weather.Humidity,
                      ),
                      cardwidget(
                        image: "assets/rain.png",
                        label: widget.weather.Rain.toString(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            TitleTextWidget(title: "Houly"),
            Container(
                width: double.infinity,
                height: screensize.height / 5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.hourlyweather.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                        child: Hourly_Card(
                      screensize: screensize,
                      hourly: widget.hourlyweather[index],
                    ));
                  },
                )),
            TitleTextWidget(title: "Next 6 days"),
            Expanded(
              child: ListView.separated(
                itemCount: widget.dailyweather.length,
                itemBuilder: (context, index) {
                  return DailyCard(
                    weather: widget.dailyweather[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.black,
                    indent: 50,
                    endIndent: 50,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class cardwidget extends StatelessWidget {
  const cardwidget({
    Key? key,
    required this.image,
    required this.label,
  }) : super(key: key);
  final String image;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Image.asset(
            image,
            height: 35,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}
