import '../entities/calculation_entity.dart';

abstract class ICalculationRepository {
  Future<List<CalculationEntity>> getHistory();
  Future<void> saveCalculation(CalculationEntity calculation);
  Future<void> clearHistory();
}