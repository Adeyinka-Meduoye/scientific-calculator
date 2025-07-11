import 'dart:math' as math;
import 'package:flutter/services.dart';
import '../models/calculator_state.dart';

class CalculatorService {
  final CalculatorState _state = CalculatorState();

  String get display => _state.display;
  String get history => _state.history;

  void handleInput(String value) {
    if (_state.hasError) _state.clearAll();

    switch (value) {
      case 'C':
        _state.clearAll();
        break;
      case '⌫':
        _backspace();
        break;
      case '+':
      case '-':
      case '×':
      case '÷':
      case '^':
        _setOperator(value);
        break;
      case '=':
        _calculateResult();
        break;
      case '±':
        _toggleSign();
        break;
      case '%':
        _percentage();
        break;
      case '√':
        _squareRoot();
        break;
      case 'sin':
      case 'cos':
      case 'tan':
      case 'log':
      case 'ln':
        _applyFunction(value);
        break;
      case 'π':
        _state.display = math.pi.toString();
        _state.isNewInput = true;
        break;
      case 'e':
        _state.display = math.e.toString();
        _state.isNewInput = true;
        break;
      case 'MC':
        _state.memory = 0.0;
        break;
      case 'MR':
        _state.display = _state.memory.toString();
        break;
      case 'M+':
        _memoryAdd();
        break;
      case 'M-':
        _memorySubtract();
        break;
      case '.':
        _addDecimal();
        break;
      default:
        _inputDigit(value);
    }
  }

  void _inputDigit(String digit) {
    if (_state.isNewInput) {
      _state.display = digit == '.' ? '0.' : digit;
      _state.isNewInput = false;
    } else {
      if (digit == '.' && _state.display.contains('.')) return;
      _state.display += digit;
    }
  }

  void _addDecimal() {
    if (!_state.display.contains('.')) {
      _state.display += '.';
      _state.isNewInput = false;
    }
  }

  void _toggleSign() {
    if (_state.display.startsWith('-')) {
      _state.display = _state.display.substring(1);
    } else {
      _state.display = '-${_state.display}';
    }
  }

  void _percentage() {
    try {
      final value = double.parse(_state.display);
      _state.display = (value / 100).toString();
    } catch (_) {
      _state.setError();
    }
  }

  void _squareRoot() {
    try {
      final value = double.parse(_state.display);
      if (value < 0) throw Exception();
      _state.display = math.sqrt(value).toString();
    } catch (_) {
      _state.setError();
    }
  }

  void _applyFunction(String fn) {
    try {
      final value = double.parse(_state.display);
      double result;
      switch (fn) {
        case 'sin':
          result = math.sin(value);
          break;
        case 'cos':
          result = math.cos(value);
          break;
        case 'tan':
          result = math.tan(value);
          break;
        case 'log':
          if (value <= 0) throw Exception();
          result = math.log(value) / math.ln10;
          break;
        case 'ln':
          if (value <= 0) throw Exception();
          result = math.log(value);
          break;
        default:
          return;
      }
      _state.display = result.toString();
      _state.isNewInput = true;
    } catch (_) {
      _state.setError();
    }
  }

  void _setOperator(String op) {
    try {
      _state.firstOperand = double.parse(_state.display);
      _state.operator = op;
      _state.isNewInput = true;
    } catch (_) {
      _state.setError();
    }
  }

  void _calculateResult() {
    if (_state.operator == null || _state.firstOperand == null) return;
    try {
      final secondOperand = double.parse(_state.display);
      double result;
      switch (_state.operator) {
        case '+':
          result = _state.firstOperand! + secondOperand;
          break;
        case '-':
          result = _state.firstOperand! - secondOperand;
          break;
        case '×':
          result = _state.firstOperand! * secondOperand;
          break;
        case '÷':
          if (secondOperand == 0) throw Exception();
          result = _state.firstOperand! / secondOperand;
          break;
        case '^':
          result = math.pow(_state.firstOperand!, secondOperand).toDouble();
          break;
        default:
          return;
      }
      _state.history = '${_state.firstOperand} ${_state.operator} $secondOperand';
      _state.display = result.toString();
      _state.firstOperand = null;
      _state.operator = null;
      _state.isNewInput = true;
    } catch (_) {
      _state.setError();
    }
  }

  void _backspace() {
    if (_state.display.length > 1) {
      _state.display = _state.display.substring(0, _state.display.length - 1);
    } else {
      _state.display = '0';
      _state.isNewInput = true;
    }
  }

  void _memoryAdd() {
    try {
      _state.memory += double.parse(_state.display);
    } catch (_) {
      _state.setError();
    }
  }

  void _memorySubtract() {
    try {
      _state.memory -= double.parse(_state.display);
    } catch (_) {
      _state.setError();
    }
  }

  void handleKeyboardInput(LogicalKeyboardKey key) {
    final keyMap = {
      LogicalKeyboardKey.digit0: '0',
      LogicalKeyboardKey.digit1: '1',
      LogicalKeyboardKey.digit2: '2',
      LogicalKeyboardKey.digit3: '3',
      LogicalKeyboardKey.digit4: '4',
      LogicalKeyboardKey.digit5: '5',
      LogicalKeyboardKey.digit6: '6',
      LogicalKeyboardKey.digit7: '7',
      LogicalKeyboardKey.digit8: '8',
      LogicalKeyboardKey.digit9: '9',
      LogicalKeyboardKey.numpadAdd: '+',
      LogicalKeyboardKey.numpadSubtract: '-',
      LogicalKeyboardKey.numpadMultiply: '×',
      LogicalKeyboardKey.numpadDivide: '÷',
      LogicalKeyboardKey.numpadEnter: '=',
      LogicalKeyboardKey.enter: '=',
      LogicalKeyboardKey.backspace: '⌫',
      LogicalKeyboardKey.delete: 'C',
      LogicalKeyboardKey.period: '.',
    };
    if (keyMap.containsKey(key)) {
      handleInput(keyMap[key]!);
    }
  }
} 
