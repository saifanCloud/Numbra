import 'package:flutter/material.dart';
import '../../core/calculator/calculator_engine.dart';
import '../../core/calculator/calculator_operation.dart';
import '../../domain/entities/calculation_entity.dart';
import '../../domain/usecases/add_calculation_usecase.dart';
import '../../domain/usecases/get_calculation_history_usecase.dart';
import '../../domain/usecases/clear_calculation_history_usecase.dart';

class CalculatorController extends ChangeNotifier {
  final CalculatorEngine _engine = CalculatorEngine();
  final AddCalculationUseCase _addCalculationUseCase;
  final GetCalculationHistoryUseCase _getHistoryUseCase;
  final ClearCalculationHistoryUseCase _clearHistoryUseCase;
  
  List<CalculationEntity> _history = [];
  bool _isLoading = false;
  
  // Getters
  String get display => _engine.display;
  String get expression => _engine.expression;
  List<CalculationEntity> get history => _history;
  bool get isLoading => _isLoading;
  bool get isError => _engine.isError;
  
  CalculatorController({
    required AddCalculationUseCase addCalculationUseCase,
    required GetCalculationHistoryUseCase getHistoryUseCase,
    required ClearCalculationHistoryUseCase clearHistoryUseCase,
  }) : _addCalculationUseCase = addCalculationUseCase,
       _getHistoryUseCase = getHistoryUseCase,
       _clearHistoryUseCase = clearHistoryUseCase {
    _loadHistory();
  }
  
  // ========== CALCULATOR ACTIONS ==========
  
  void inputNumber(String digit) {
    _engine.inputNumber(digit);
    notifyListeners();
  }
  
  void inputDecimal() {
    _engine.inputDecimal();
    notifyListeners();
  }
  
  void inputOperator(CalculatorOperation operation) {
    _engine.inputOperator(operation);
    notifyListeners();
  }
  
  void calculate() {
    _engine.calculate();
    _saveToHistory();
    notifyListeners();
  }
  
  void calculatePercentage() {
    _engine.percentage();
    notifyListeners();
  }
  
  void toggleSign() {
    _engine.toggleSign();
    notifyListeners();
  }
  
  void clear() {
    _engine.clear();
    notifyListeners();
  }
  
  void clearAll() {
    _engine.clearAll();
    notifyListeners();
  }
  
  void backspace() {
    _engine.backspace();
    notifyListeners();
  }
  
  // ========== HISTORY METHODS ==========
  
  Future<void> _loadHistory() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _history = await _getHistoryUseCase.execute();
    } catch (e) {
      _history = [];
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> _saveToHistory() async {
    // Check if we have a calculation result to save
    if (_engine.expression.isEmpty || _engine.isError) return;
    
    final calculation = CalculationEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      expression: _engine.expression,
      result: _engine.display,
      timestamp: DateTime.now(),
    );
    
    await _addCalculationUseCase.execute(calculation);
    await _loadHistory();
  }
  
  Future<void> clearHistory() async {
    await _clearHistoryUseCase.execute();
    await _loadHistory();
    notifyListeners();
  }
  
  void reset() {
    _engine.reset();
    notifyListeners();
  }
}