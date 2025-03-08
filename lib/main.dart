import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomodoro_timer/home_page.dart';

GetIt getIt = GetIt.instance;

void main() async {
  getIt.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xff3F51B5),
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xff303F9F),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Color(0xff3F51B5),
        ),
      ),
      home: PomodoroHomePage(),
    );
  }
}
