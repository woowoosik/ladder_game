import 'package:flutter/material.dart';
import 'package:ladder_game/mainScreen.dart';
import 'package:provider/provider.dart';
import 'package:ladder_game/viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ViewModel()),
        //ChangeNotifierProvider(create: (_) => GameViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ladder Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: mainScreen(),
    );
  }
}
