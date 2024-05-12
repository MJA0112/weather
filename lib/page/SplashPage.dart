import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:faradars_weather/Constants.dart';
import 'package:faradars_weather/model/HourlyWeather.dart';
import 'package:faradars_weather/model/weathermodel.dart';
import 'package:faradars_weather/page/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:open_settings/open_settings.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List<HourlyModel> hourlylist = [];
  WeatherModel? mainweather;
  List<WeatherModel> daysweather = [];

  Future<void> GomainPage() async {
    // await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          weather: mainweather!,
          hourlyweather: hourlylist,
          dailyweather: daysweather,
        ),
      ),
    );
    // print(daysweather.length);
  }

  Future<void> getApi(lat, lon) async {
    String path =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=${Constants.appid}";
    Uri url = Uri.parse(path);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      WeatherModel weather = WeatherModel.fromJson(res);
      getHourlyWeather(weather.latitude, weather.lonitude);
      mainweather = weather;
    } else {
      return;
    }
  }

  Future<void> getHourlyWeather(String lat, String lon) async {
    String path =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=f306e0035f0b69eb7ff0922565e53750";
    Uri url = Uri.parse(path);
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      forcast_DailyWeather(res, lat, lon);
      for (int i = 5; i <= 20; i += 2) {
        final HourlyModel hourly = HourlyModel.fromjson(res, i);
        hourlylist.add(hourly);
      }
    }
  }

  void forcast_DailyWeather(
      Map<String, dynamic> json, String lat, String lon) async {
    for (int i = 1; i < 8; i++) {
      final WeatherModel day =
          WeatherModel.fromjsonDays(json, 'daily', i, lat, lon);
      daysweather.add(day);
    }
    print(daysweather.length);
    GomainPage();
  }

  Future<void> getposition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        getposition();
      } else {
        getpos();
      }
    } else {
      getpos();
    }
  }

  void getpos() async {
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await getApi(pos.latitude, pos.longitude);
  }

  @override
  void initState() {
    super.initState();
    // getApi();
    checkconnectivity();
  }

  void checkconnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      getposition();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("عدم برقراری ارتباط"),
          actions: [
            Container(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  await OpenSettings.openWIFISetting();
                },
                child: Text("wifi"),
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  await OpenSettings.openDataRoamingSetting();
                },
                child: Text("mobile data"),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 204, 104),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.cyan,
            Colors.blue,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: SpinKitRipple(
              color: Colors.white,
              size: 80,
            ))
          ],
        ),
      ),
    );
  }
}
