import 'calculator_operation.dart';
import 'calculator_state.dart';
import 'calculator_exception.dart';
import '../utils/formatter_utils.dart';

class CalculatorEngine {
  static const int maxDigits = 10;
  
  CalculatorState _state = const CalculatorState();
  
  // Getters
  CalculatorState get state => _state;
  String get display => _state.display;
  String get expression => _state.expression;
  bool get isError => _state.isError;
  
  // ========== PUBLIC METHODS ==========
  
  void inputNumber(String digit) {
    if (_state.isError) _clearError();
    
    if (!_isValidNumber(digit)) {
      throw InvalidInputException(digit);
    }
    
    String newDisplay;
    
    if (_state.isNewNumber) {
      newDisplay = digit;
    } else {
      final cleanDisplay = _state.display.replaceAll(' ', '');
      if (cleanDisplay.length >= maxDigits) return;
      newDisplay = '${_state.display}$digit';
    }
    
    _state = _state.copyWith(
      display: newDisplay,
      isNewNumber: false,
    );
  }
  
  void inputDecimal() {
    if (_state.isError) _clearError();
    
    if (_state.isNewNumber) {
      _state = _state.copyWith(
        display: '0.',
        isNewNumber: false,
      );
      return;
    }
    
    if (_state.display.contains('.')) return;
    
    _state = _state.copyWith(
      display: '${_state.display}.',
    );
  }
  
  void inputOperator(CalculatorOperation operation) {
    if (_state.isError) _clearError();
    
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
  
  void calculate() {
    if (_state.isError) _clearError();
    if (_state.currentOperation == CalculatorOperation.none) return;
    _calculate();
  }
  
  void percentage() {
    if (_state.isError) _clearError();
    
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
  
  void toggleSign() {
    if (_state.isError) _clearError();
    if (_state.display == '0') return;
    
    String newDisplay;
    if (_state.display.startsWith('-')) {
      newDisplay = _state.display.substring(1);
    } else {
      newDisplay = '-${_state.display}';
    }
    
    _state = _state.copyWith(display: newDisplay);
  }
  
  void clear() {
    _state = _state.copyWith(
      display: '0',
      isNewNumber: true,
    );
  }
  
  void clearAll() {
    _state = const CalculatorState();
  }
  
  void backspace() {
    if (_state.isError) {
      _clearError();
      return;
    }
    
    if (_state.display.length > 1) {
      final newDisplay = _state.display.substring(0, _state.display.length - 1);
      _state = _state.copyWith(display: newDisplay);
    } else {
      _state = _state.copyWith(
        display: '0',
        isNewNumber: true,
      );
    }
  }
  
  void reset() {
    _state = const CalculatorState();
  }
  
  // ========== PRIVATE METHODS ==========
  
  void _calculate() {
    if (_state.currentOperation == CalculatorOperation.none) return;
    
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
          if (secondNumber == 0) throw DivisionByZeroException();
          result = _state.firstNumber / secondNumber;
          break;
        default:
          return;
      }
      
      if (result.isInfinite || result.isNaN) {
        _setError();
        return;
      }
      
      final formattedResult = _formatNumber(result.toString());
      final fullExpression = '$expressionText = $formattedResult';
      
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
      final clean = _state.display.replaceAll(' ', '');
      return double.parse(clean);
    } catch (e) {
      throw InvalidInputException(_state.display);
    }
  }
  
  String _formatNumber(String number) {
    return FormatterUtils.formatNumber(number);
  }
  
  String _getOperatorSymbol(CalculatorOperation operation) {
    switch (operation) {
      case CalculatorOperation.add: return '+';
      case CalculatorOperation.subtract: return '-';
      case CalculatorOperation.multiply: return '×';
      case CalculatorOperation.divide: return '÷';
      default: return '';
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