import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/calculator/calculator_engine.dart';
import '../../core/calculator/calculator_operation.dart';
import '../../domain/entities/calculation_entity.dart';
import '../../domain/usecases/add_calculation_usecase.dart';
import '../../domain/usecases/get_calculation_history_usecase.dart';
import '../../domain/usecases/clear_calculation_history_usecase.dart';
// Mengimpor SDK Flutter, SharedPreferences, mesin kalkulator core, serta usecase domain yang dibutuhkan.



class CalculatorController extends ChangeNotifier {
  final CalculatorEngine _engine = CalculatorEngine();
  final AddCalculationUseCase _addCalculationUseCase;
  final GetCalculationHistoryUseCase _getHistoryUseCase;
  final ClearCalculationHistoryUseCase _clearHistoryUseCase;
  final SharedPreferences _sharedPreferences;
  
  List<CalculationEntity> _history = [];
  bool _isLoading = false;
  bool _isDarkTheme = true;
// Pengelolaan State privat untuk mesin perhitungan, penggunaan UseCaseClean Architecture, dan preferensi tema.



  String get display => _engine.display;
  String get expression => _engine.expression;
  List<CalculationEntity> get history => _history;
  bool get isLoading => _isLoading;
  bool get isError => _engine.isError;
  bool get isDarkTheme => _isDarkTheme;
// Getter publik untuk memberikan akses read-only pada data state ke tampilan UI.



  CalculatorController({
    required AddCalculationUseCase addCalculationUseCase,
    required GetCalculationHistoryUseCase getHistoryUseCase,
    required ClearCalculationHistoryUseCase clearHistoryUseCase,
    required SharedPreferences sharedPreferences,
  }) : _addCalculationUseCase = addCalculationUseCase,
       _getHistoryUseCase = getHistoryUseCase,
       _clearHistoryUseCase = clearHistoryUseCase,
       _sharedPreferences = sharedPreferences {
    _loadHistory();
    _loadTheme();
  }
// Konstruktor pengontrol yang menginisialisasi dependensi usecase serta memuat riwayat dan preferensi tema tersimpan.



  void _loadTheme() {
    _isDarkTheme = _sharedPreferences.getBool('is_dark_theme') ?? true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    await _sharedPreferences.setBool('is_dark_theme', _isDarkTheme);
    notifyListeners();
  }
// Metode untuk memuat dan membalikkan status tema gelap/terang serta menyimpannya secara permanen ke SharedPreferences.



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
// Metode penanganan input digit angka, tanda desimal titik (.), dan operator matematika (+, -, X, /).



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
// Metode eksekusi perhitungan matematika (sama dengan, persentase, ubah tanda, hapus karakter, dan reset tombol).



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
// Metode privat dan publik untuk memuat, menambah, dan mengosongkan riwayat kalkulasi dari penyimpan lokal.
}