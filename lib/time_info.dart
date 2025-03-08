import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerModel {
  final String time;
  final double percent;
  final int passedSeconds;

  TimerModel({
    required this.time,
    required this.percent,
    required this.passedSeconds,
  });
}

class CountDownTimer {
  int workTime = 30;
  int shortBreak = 5;
  int longBreak = 20;

  SharedPreferences prefs = GetIt.instance.get<SharedPreferences>();

  late double _percent;
  late Duration _time;
  late Duration _fullTime;
  bool _isAlive = false;

  bool get isAlive {
    return _isAlive;
  }

  void startWorkTimer() async {
    await readSettings();
    _time = Duration(minutes: workTime);
    _fullTime = Duration(minutes: workTime);

    if (_time.inSeconds > 0) {
      _isAlive = true;
    }
  }

  void startBreakTimer({bool? isShort}) async {
    await readSettings();
    _time = Duration(
      minutes: (isShort != null && isShort) ? shortBreak : longBreak,
    );
    _fullTime = Duration(
      minutes: (isShort != null && isShort) ? shortBreak : longBreak,
    );

    if (_time.inSeconds > 0) {
      _isAlive = true;
    }
  }

  void stopTimer() {
    _isAlive = false;
  }

  void resumeTimer() {
    if (_time.inSeconds > 0) {
      _isAlive = true;
    }
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int n) {
      if (_isAlive) {
        _time -= Duration(seconds: 1);
        _percent = _time.inSeconds / _fullTime.inSeconds;
        if (_time.inSeconds <= 0) {
          _isAlive = false;
        }
      }
      return TimerModel(
        time: formatTime(_time),
        percent: _percent,
        passedSeconds: _fullTime.inSeconds - _time.inSeconds,
      );
    });
  }

  String formatTime(Duration t) {
    final String minutes = "${t.inMinutes < 10 ? '0' : ''}${t.inMinutes}";
    final int numSeconds = t.inSeconds - (t.inMinutes * 60);
    final String seconds = "${numSeconds < 10 ? '0' : ''}$numSeconds";

    return "$minutes:$seconds";
  }

  Future readSettings() async {
    workTime = prefs.getInt('workTime') ?? 30;
    shortBreak = prefs.getInt('shortBreak') ?? 5;
    longBreak = prefs.getInt('longBreak') ?? 20;
  }
}

class TimeView extends StatelessWidget {
  final double availableWidth;
  final CountDownTimer timer;

  const TimeView({
    super.key,
    required this.availableWidth,
    required this.timer,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: '00:00',
      stream: timer.stream(),
      builder: (BuildContext context, AsyncSnapshot snapShot) {
        final TimerModel currentTime =
            snapShot.data == '00:00'
                ? TimerModel(time: '00:00', percent: 1, passedSeconds: 0)
                : snapShot.data;

        return CircularPercentIndicator(
          radius: availableWidth - 10,
          lineWidth: 10,
          progressColor: Color(0xff4CAF50),
          percent: currentTime.percent,
          center: Text(
            currentTime.time,
            style: TextStyle(
              color:
                  timer.isAlive
                      ? Color(0xff212121)
                      : Color.fromARGB(255, 82, 81, 81),
            ),
          ),
        );
      },
    );
  }
}
