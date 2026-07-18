import 'calculator_operation.dart';

class CalculatorState {
  final String display;
  final String expression;
  final double firstNumber;
  final CalculatorOperation currentOperation;
  final bool isNewNumber;
  final bool isError;
  
  const CalculatorState({
    this.display = '0',
    this.expression = '',
    this.firstNumber = 0.0,
    this.currentOperation = CalculatorOperation.none,
    this.isNewNumber = true,
    this.isError = false,
  });
  
  CalculatorState copyWith({
    String? display,
    String? expression,
    double? firstNumber,
    CalculatorOperation? currentOperation,
    bool? isNewNumber,
    bool? isError,
  }) {
    return CalculatorState(
      display: display ?? this.display,
      expression: expression ?? this.expression,
      firstNumber: firstNumber ?? this.firstNumber,
      currentOperation: currentOperation ?? this.currentOperation,
      isNewNumber: isNewNumber ?? this.isNewNumber,
      isError: isError ?? this.isError,
    );
  }
}