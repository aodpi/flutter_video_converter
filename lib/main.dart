import 'package:flutter/material.dart';
import 'package:flutter_video_converter/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.dark(
          secondary: Color(0xff2980b9),
          background: Color(0xff2c3e50),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff2c3e50),
          shape: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            color: Colors.white,
          ),
        ),
        segmentedButtonTheme: const SegmentedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.white),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        )),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
