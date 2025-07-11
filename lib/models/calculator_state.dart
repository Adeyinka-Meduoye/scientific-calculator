

class CalculatorState {
  String display;
  String history;
  double? firstOperand;
  String? operator;
  double memory;
  bool isNewInput;
  bool hasError;

  CalculatorState({
    this.display = '0',
    this.history = '',
    this.firstOperand,
    this.operator,
    this.memory = 0.0,
    this.isNewInput = true,
    this.hasError = false,
  });

  void clearAll() {
    display = '0';
    history = '';
    firstOperand = null;
    operator = null;
    isNewInput = true;
    hasError = false;
  }

  void setError() {
    display = 'Error';
    hasError = true;
  }

  CalculatorState clone() {
    return CalculatorState(
      display: display,
      history: history,
      firstOperand: firstOperand,
      operator: operator,
      memory: memory,
      isNewInput: isNewInput,
      hasError: hasError,
    );
  }
} 
