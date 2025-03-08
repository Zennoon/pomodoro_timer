import 'package:flutter/material.dart';
import 'package:pomodoro_timer/widgets.dart';
import 'package:pomodoro_timer/time_info.dart';

class PomodoroHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final timer = CountDownTimer();

  PomodoroHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    timer.startWorkTimer();
    return Scaffold(
      appBar: AppBar(title: Text('Pomodoro Timer')),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final availableWidth = constraints.maxWidth;

          return Column(
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff4CAF50),
                      text: 'Work',
                      onPressed: timer.startWorkTimer,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xffC5CAE9),
                      text: 'Short Break',
                      textStyle: TextStyle(color: Color(0xff212121)),
                      onPressed: () => timer.startBreakTimer(isShort: true),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff757575),
                      text: 'Long Break',
                      onPressed: timer.startBreakTimer,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
              Expanded(child: TimeView(timer: timer, availableWidth: availableWidth)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff212121),
                      text: 'Stop',
                      onPressed: timer.stopTimer,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff4CAF50),
                      text: 'Resume',
                      onPressed: timer.resumeTimer,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void emptyMethod() {}
}
