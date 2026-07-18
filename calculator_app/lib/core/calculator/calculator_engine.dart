import 'calculator_operation.dart';
import 'calculator_state.dart';
import 'calculator_exception.dart';

/// Core business logic for calculator
class CalculatorEngine {
  // Constants
  static const int MAX_DIGITS = 10;
  
  // Current state
  CalculatorState _state = const CalculatorState();
  
  // Getters
  CalculatorState get state => _state;
  String get display => _state.display;
  String get expression => _state.expression;
  bool get isError => _state.isError;
  
  // ========== PUBLIC METHODS ==========
  
  /// Input a number (0-9)
  void inputNumber(String digit) {
    if (_state.isError) {
      _clearError();
    }
    
    if (!_isValidNumber(digit)) {
      throw InvalidInputException(digit);
    }
    
    String newDisplay;
    
    if (_state.isNewNumber) {
      newDisplay = digit;
    } else {
      // Prevent exceeding max digits
      final cleanDisplay = _state.display.replaceAll('.', '');
      if (cleanDisplay.length >= MAX_DIGITS) {
        return;
      }
      newDisplay = _state.display + digit;
    }
    
    _state = _state.copyWith(
      display: newDisplay,
      isNewNumber: false,
    );
  }
  
  /// Input decimal point
  void inputDecimal() {
    if (_state.isError) {
      _clearError();
    }
    
    // If new number, start with "0."
    if (_state.isNewNumber) {
      _state = _state.copyWith(
        display: '0.',
        isNewNumber: false,
      );
      return;
    }
    
    // Prevent multiple decimals
    if (_state.display.contains('.')) {
      return;
    }
    
    _state = _state.copyWith(
      display: _state.display + '.',
    );
  }
  
  /// Input operator (+, -, ×, ÷)
  void inputOperator(CalculatorOperation operation) {
    if (_state.isError) {
      _clearError();
    }
    
    // If there's a pending operation and it's not a new number, calculate first
    if (_state.currentOperation != CalculatorOperation.none && !_state.isNewNumber) {
      _calculate();
    }
    
    final currentNumber = _parseDisplay();
    final operatorSymbol = _getOperatorSymbol(operation);
    
    _state = _state.copyWith(
      firstNumber: currentNumber,
      currentOperation: operation,
      expression: '${_formatNumber(_state.display)} $operatorSymbol ',
      isNewNumber: true,
    );
  }
  
  /// Calculate result
  void calculate() {
    if (_state.isError) {
      _clearError();
    }
    
    if (_state.currentOperation == CalculatorOperation.none) {
      return;
    }
    
    _calculate();
  }
  
  /// Calculate percentage
  void percentage() {
    if (_state.isError) {
      _clearError();
    }
    
    try {
      final currentNumber = _parseDisplay();
      final result = currentNumber / 100;
      _state = _state.copyWith(
        display: _formatNumber(result.toString()),
        isNewNumber: true,
      );
    } catch (e) {
      _setError();
    }
  }
  
  /// Toggle positive/negative sign
  void toggleSign() {
    if (_state.isError) {
      _clearError();
    }
    
    if (_state.display == '0') {
      return;
    }
    
    String newDisplay;
    if (_state.display.startsWith('-')) {
      newDisplay = _state.display.substring(1);
    } else {
      newDisplay = '-$_state.display';
    }
    
    _state = _state.copyWith(
      display: newDisplay,
    );
  }
  
  /// Clear current entry (C)
  void clear() {
    _state = _state.copyWith(
      display: '0',
      isNewNumber: true,
    );
  }
  
  /// Clear all (AC)
  void clearAll() {
    _state = const CalculatorState();
  }
  
  /// Backspace / delete last character (⌫)
  void backspace() {
    if (_state.isError) {
      _clearError();
      return;
    }
    
    if (_state.display.length > 1) {
      final newDisplay = _state.display.substring(0, _state.display.length - 1);
      _state = _state.copyWith(
        display: newDisplay,
      );
    } else {
      // If only 1 character, reset to 0
      _state = _state.copyWith(
        display: '0',
        isNewNumber: true,
      );
    }
  }
  
  /// Reset state (for testing)
  void reset() {
    _state = const CalculatorState();
  }
  
  // ========== PRIVATE METHODS ==========
  
  void _calculate() {
    if (_state.currentOperation == CalculatorOperation.none) {
      return;
    }
    
    try {
      final secondNumber = _parseDisplay();
      double result = 0.0;
      String operatorSymbol = _getOperatorSymbol(_state.currentOperation);
      String expressionText = '${_formatNumber(_state.firstNumber.toString())} $operatorSymbol ${_formatNumber(_state.display)}';
      
      switch (_state.currentOperation) {
        case CalculatorOperation.add:
          result = _state.firstNumber + secondNumber;
          break;
        case CalculatorOperation.subtract:
          result = _state.firstNumber - secondNumber;
          break;
        case CalculatorOperation.multiply:
          result = _state.firstNumber * secondNumber;
          break;
        case CalculatorOperation.divide:
          if (secondNumber == 0) {
            throw DivisionByZeroException();
          }
          result = _state.firstNumber / secondNumber;
          break;
        default:
          return;
      }
      
      // Check for overflow
      if (result.isInfinite || result.isNaN) {
        _setError();
        return;
      }
      
      final formattedResult = _formatNumber(result.toString());
      final fullExpression = '$expressionText = $formattedResult';
      
      // Update state
      _state = _state.copyWith(
        display: formattedResult,
        expression: fullExpression,
        firstNumber: 0.0,
        currentOperation: CalculatorOperation.none,
        isNewNumber: true,
      );
      
    } on DivisionByZeroException {
      _setError();
    } catch (e) {
      _setError();
    }
  }
  
  double _parseDisplay() {
    try {
      return double.parse(_state.display);
    } catch (e) {
      throw InvalidInputException(_state.display);
    }
  }
  
  String _formatNumber(String number) {
    if (number == 'Error' || number == 'Infinity' || number == 'NaN') {
      return 'Error';
    }
    
    try {
      final parsed = double.parse(number);
      
      // Handle special cases
      if (parsed.isInfinite || parsed.isNaN) {
        return 'Error';
      }
      
      // Format with thousand separators (dots for Indonesian format)
      final parts = number.split('.');
      final integerPart = parts[0];
      final decimalPart = parts.length > 1 ? '.${parts[1]}' : '';
      
      // Add thousand separators
      final formattedInteger = integerPart.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]}.',
      );
      
      // Limit decimal places to 10
      String formattedDecimal = decimalPart;
      if (decimalPart.length > 11) {
        formattedDecimal = decimalPart.substring(0, 11);
      }
      
      return formattedInteger + formattedDecimal;
    } catch (e) {
      return number;
    }
  }
  
  String _getOperatorSymbol(CalculatorOperation operation) {
    switch (operation) {
      case CalculatorOperation.add:
        return '+';
      case CalculatorOperation.subtract:
        return '-';
      case CalculatorOperation.multiply:
        return '×';
      case CalculatorOperation.divide:
        return '÷';
      default:
        return '';
    }
  }
  
  bool _isValidNumber(String digit) {
    return digit.length == 1 && digit.codeUnitAt(0) >= 48 && digit.codeUnitAt(0) <= 57;
  }
  
  void _setError() {
    _state = _state.copyWith(
      display: 'Error',
      expression: '',
      isError: true,
      isNewNumber: true,
    );
  }
  
  void _clearError() {
    _state = _state.copyWith(
      isError: false,
      display: '0',
      isNewNumber: true,
    );
  }
}