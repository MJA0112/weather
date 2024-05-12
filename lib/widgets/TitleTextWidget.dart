import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black87, fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}
