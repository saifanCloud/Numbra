import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_strings.dart';
import '../../models/calculation_model.dart';

class SharedPreferencesDatasource {
  final SharedPreferences _preferences;
  
  SharedPreferencesDatasource(this._preferences);
  
  Future<List<CalculationModel>> getCalculations() async {
    final String? jsonString = _preferences.getString(AppStrings.prefHistoryKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    
    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((json) => CalculationModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }
  
  Future<void> saveCalculations(List<CalculationModel> calculations) async {
    final List<Map<String, dynamic>> jsonList = calculations
        .map((calculation) => calculation.toJson())
        .toList();
    
    final String jsonString = json.encode(jsonList);
    await _preferences.setString(AppStrings.prefHistoryKey, jsonString);
  }
  
  Future<void> clearCalculations() async {
    await _preferences.remove(AppStrings.prefHistoryKey);
  }
}