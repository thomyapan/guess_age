import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:guess_age/services/api.dart';

class Guess extends StatefulWidget {
  static const routeName = '/guess';
  const Guess({Key? key}) : super(key: key);

  @override
  _GuessState createState() => _GuessState();
}

class _GuessState extends State<Guess> {
  int year = 0;
  int month = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title:  Text("GUESS TEACHER'S AGE",),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'อายุอาจารย์',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: new Border.all(
                        color: Colors.cyan.shade500,
                        width: 5.0,
                        style: BorderStyle.solid),
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SpinBox(
                        decoration: InputDecoration(labelText: 'ปี'),
                        min: 1,
                        max: 100,
                        value: 0,
                        textStyle: TextStyle(fontSize: 40),
                        onChanged: (value) {
                          year = value.toInt();
                          print(year);
                        },
                      ),
                      SpinBox(
                        decoration: InputDecoration(labelText: 'เดือน'),
                        min: 1,
                        max: 12,
                        value: 0,
                        textStyle: TextStyle(fontSize: 40),
                        onChanged: (value) {
                          month = value.toInt();
                          print(month);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 26.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.cyan,
                            ),
                            onPressed: _handleClickButton,
                            child: Text(
                              'ทาย',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          elevation: 5,
          backgroundColor: Colors.blue.withOpacity(0.5),
          title: Text(title, style: TextStyle(
              fontSize: 30,
              color: Colors.yellow.shade800),),
          content: Text(msg,  style: TextStyle(
              fontSize: 20,

              color: Colors.white),),
          actions: [
            TextButton(
              child: Text('OK',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.red,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _handleClickButton() async {
    var guess = await _login(year, month);

    if (guess['value'] == true) {
      Navigator.pushReplacementNamed(
        context,
        '/page',
        arguments: {'year': year,'month': month},
      );
    } else {
      _showMaterialDialog('ผลการทาย', '${guess['text']}');
    }
  }

  Future<dynamic> _login(int y, int m) async {
    try {
      var isLogin =
      (await Api().submit('guess_teacher_age', {'year': y, 'month': m}));
      print('LOGIN: $isLogin');
      return isLogin;
    } catch (e) {
      print(e);
      _showMaterialDialog('ERROR', e.toString());
      return null;
    }
  }
}