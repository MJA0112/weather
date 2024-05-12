import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Future<bool?> DataIsvalid_future() async {
    await Future.delayed(Duration(seconds: 4));
    // return Future.error("Divide by zero exception");
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          FutureBuilder(
            initialData: true,
            future: DataIsvalid_future(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.green,
                  width: 200,
                  height: 200,
                  child: Text("Correct"),
                );
              } else if (snapshot.hasError) {
                return Container(
                  color: Colors.red,
                  width: 200,
                  height: 200,
                  child: Text("error"),
                );
              } else {
                return Container(
                  color: Colors.blue,
                  width: 200,
                  height: 200,
                  child: Text("DEfault"),
                );
              }
            },
          )
        ],
      )),
    );
  }
}
