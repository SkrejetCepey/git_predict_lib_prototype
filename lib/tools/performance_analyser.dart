import 'package:flutter/material.dart';

class PerformanceAnalyser {

  Stopwatch _timer = Stopwatch();
  final BuildContext context;

  PerformanceAnalyser({@required this.context});

  void start() {
    _timer.start();
  }

  void _showElapsedTime() {
    SnackBar snack = SnackBar(content: Text(_timer.elapsed.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void stop() {
    _timer.stop();
    print(_timer.elapsed);
    _showElapsedTime();
  }
}