import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_app_with_db/controller/provider.dart';
import 'package:student_app_with_db/view/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StudentProvider.instance.initDataBase();

  runApp(ChangeNotifierProvider<StudentProvider>(
    create: (context) => StudentProvider.instance,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
