import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const maxSecond = 60;
  int second = maxSecond;
  Timer? timer;

  resetTimer() => setState(() => second = maxSecond);

  runTimer() {
    timer = Timer.periodic(
      Duration(milliseconds: 50),
      (_) {
        if (second > 0) {
          setState(
            () {
              second--;
            },
          );
        } else {
          stopTimer(reset: false);
        }
      },
    );
  }

  stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer Testing',
      theme: ThemeData(primaryColor: Colors.white),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Timer Testing'),
        ),
        body: Container(
          height: 600,
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // SizedBox(
              //   height: 200,
              //   width: 200,
              //   child: Stack(
              //     fit: StackFit.expand,
              //     children: <Widget>[
              //       CircularProgressIndicator(
              //         value: second / maxSecond,
              //       ),
              Container(
                padding: EdgeInsets.all(28),
                child: Text(
                  '$second',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 80,
                  ),
                ),
              ),
              // ],
              //   ),
              // ),
              const SizedBox(
                height: 50,
              ),
              timer?.isActive ?? false
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: stopTimer,
                        ),
                        const SizedBox(width: 16),
                        RaisedButton(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            timer?.isActive ?? false ? 'Pause' : 'Resume',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            if (timer?.isActive ?? false) {
                              stopTimer(reset: false);
                            }
                          },
                        )
                      ],
                    )
                  : RaisedButton(
                      padding: EdgeInsets.all(10),
                      onPressed: runTimer,
                      child: Text(
                        'Start Timer',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
