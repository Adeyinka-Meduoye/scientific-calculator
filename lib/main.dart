import 'package:flutter/material.dart';
import 'screens/calculator_home.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CalculatorHome();
  }
}
