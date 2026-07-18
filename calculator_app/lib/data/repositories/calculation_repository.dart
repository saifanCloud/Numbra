import '../../domain/entities/calculation_entity.dart';
import '../../domain/repositories/i_calculation_repository.dart';
import '../datasources/local/shared_preferences_datasource.dart';
import '../models/calculation_model.dart';

class CalculationRepository implements ICalculationRepository {
  final SharedPreferencesDatasource _datasource;
  
  CalculationRepository(this._datasource);
  
  @override
  Future<List<CalculationEntity>> getHistory() async {
    final models = await _datasource.getCalculations();
    return models;
  }
  
  @override
  Future<void> saveCalculation(CalculationEntity calculation) async {
    final currentHistory = await _datasource.getCalculations();
    final newModel = CalculationModel.fromEntity(calculation);
    final updatedHistory = [newModel, ...currentHistory];
    
    // Limit history to 100 items
    if (updatedHistory.length > 100) {
      updatedHistory.removeRange(100, updatedHistory.length);
    }
    
    await _datasource.saveCalculations(updatedHistory);
  }
  
  @override
  Future<void> clearHistory() async {
    await _datasource.clearCalculations();
  }
}