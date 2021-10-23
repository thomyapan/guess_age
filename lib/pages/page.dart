import 'package:flutter/material.dart';
import 'package:guess_age/pages/guess_page.dart';

class page extends StatelessWidget {
  static const routeName = '/page';
  const page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var age = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title:  Text("GUESS TEACHER'S AGE",),

      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'อายุอาจารย์',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                '${age['year']} ปี ${age['month']} เดือน',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Icon(
                Icons.check,
                size: 100,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}