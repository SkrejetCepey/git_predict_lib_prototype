import 'package:flutter/material.dart';

class PerformanceAnalyser {

  final Stopwatch _timer = Stopwatch();
  final BuildContext context;
  final String testThing;

  PerformanceAnalyser({@required this.context, @required this.testThing});

  void start() {
    _timer.start();
  }

  void _showElapsedTime() {
    SnackBar snack = SnackBar(content: Text("$testThing: ${_timer.elapsed}"));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void stop() {
    _timer.stop();
    print(_timer.elapsed);
    _showElapsedTime();
  }
}