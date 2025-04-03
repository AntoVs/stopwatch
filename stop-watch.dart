import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stopwatch',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  late Stopwatch _stopwatch;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer before starting a new one
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _startTimer();
    }
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {});
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    _timer?.cancel(); // Stop the timer when resetting
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up the timer
    super.dispose();
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / 60000).truncate();

    return "$minutes:${seconds.toString().padLeft(2, '0')}:${hundreds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stopwatch")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatTime(_stopwatch.elapsedMilliseconds),
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _startStopwatch,
                child: Text("Start"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _stopStopwatch,
                child: Text("Stop"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _resetStopwatch,
                child: Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}