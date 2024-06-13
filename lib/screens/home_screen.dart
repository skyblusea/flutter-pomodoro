import 'package:flutter/material.dart';
import 'package:pomodoro/indicator.dart';
import 'package:pomodoro/timePicker.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500; //25min * 60sec
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalRounds = 0;
  late Timer timer;
  double pickerWidth = 300;

  late ScrollController _scrollController;

  double _calculateScrollOffset(int totalSeconds) {
    double maxOffset = pickerWidth; // Example max scroll offset
    return totalSeconds / twentyFiveMinutes * maxOffset;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset:
          _calculateScrollOffset(totalSeconds), // Set initial scroll position
    );
  }

  void onTick(Timer timer) {
    //Timer 에서 time parameter를 전달하므로 timer 인자 넣기 onClick(event)와 같은 방식
    if (totalSeconds == 0) {
      stopTimer();
      setState(() {
        totalRounds++;
        totalSeconds = twentyFiveMinutes;
      });
    } else {
      setState(() {
        totalSeconds--;
        _scrollController.animateTo(
          _calculateScrollOffset(totalSeconds),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick, //함수를 당장 실행하는 것이 아니므로 onTick() xx
    );
    setState(() {
      isRunning = true;
    });
  }

  void stopTimer() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds); //flutter: 0:24:58.000000
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Flexible(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  format(totalSeconds),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          const SizedBox(
            width: 10,
            height: 30,
            child: Indicator(),
          ),
          Flexible(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: TimePicker(
                totalSeconds: totalSeconds,
                scrollController: _scrollController,
                pickerWidth: pickerWidth,
              ),
            ),
          ),
          Flexible(
              flex: 2,
              child: Center(
                  child: IconButton(
                icon: Icon(
                  isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline,
                  size: 140,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: isRunning ? stopTimer : startTimer,
              ))),
          const Spacer(flex: 2),
          Flexible(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Round'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text('$totalRounds',
                              style: const TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
