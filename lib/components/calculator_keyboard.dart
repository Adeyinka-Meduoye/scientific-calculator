import 'package:flutter/material.dart';

class CalculatorKeyboard extends StatelessWidget {
  final void Function(String) onKeyTap;

  const CalculatorKeyboard({
    super.key,
    required this.onKeyTap,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = [
      ['MC', 'MR', 'M+', 'M-'],
      ['sin', 'cos', 'tan', '√'],
      ['log', 'ln', '^', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['π', 'e', '±', '='],
      ['C', '⌫', '0', '.'],
    ];

    return Column(
      children: buttons.map((row) {
        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: row.map((label) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () => onKeyTap(label),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _buttonColor(label, context),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Color _buttonColor(String label, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (['+', '-', '×', '÷', '=', '^'].contains(label)) {
      return isDark ? Colors.deepPurple : Colors.deepPurpleAccent;
    }
    if (['C', '⌫', '%', '√', 'sin', 'cos', 'tan', 'log', 'ln', 'π', 'e'].contains(label)) {
      return isDark ? Colors.teal.shade700 : Colors.teal.shade400;
    }
    if (['MC', 'MR', 'M+', 'M-'].contains(label)) {
      return isDark ? Colors.grey.shade700 : Colors.grey.shade400;
    }
    return isDark ? Colors.grey.shade800 : Colors.grey.shade600;
  }
} 
