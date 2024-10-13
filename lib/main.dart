import 'package:flutter/material.dart';
import 'package:pad_split/ViewModel/MainPageVM.dart';
import 'package:provider/provider.dart';

import 'MainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider.value(value: MainPageViewModel()),
      ], child: const MainPage()),
    );
  }
}

