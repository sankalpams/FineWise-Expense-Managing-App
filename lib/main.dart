import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const BudgetLearningApp());
}

class BudgetLearningApp extends StatelessWidget {
  const BudgetLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
