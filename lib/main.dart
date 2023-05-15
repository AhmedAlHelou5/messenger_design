import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:messenger_design/layout/home_layout.dart';
import 'package:messenger_design/modules/counter/counter_screen.dart';
import 'package:messenger_design/shared/bloc_observer.dart';


void main() {
  Bloc.observer=MyBlocObserver();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home:  HomeLayout(),
    );
  }
}

