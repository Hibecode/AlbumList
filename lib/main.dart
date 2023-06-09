import 'package:flutter/material.dart';
import 'package:newproject/home/HomeScreen.dart';
import 'package:newproject/provider/serviceprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
      ChangeNotifierProvider(create: (_) => MainProvider()),
    ],
       child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
         home: HomeScreen(),
    ),

    );
  }
}

