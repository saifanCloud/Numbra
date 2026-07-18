import '../entities/calculation_entity.dart';
import '../repositories/i_calculation_repository.dart';

class AddCalculationUseCase {
  final ICalculationRepository _repository;
  
  AddCalculationUseCase(this._repository);
  
  Future<void> execute(CalculationEntity calculation) async {
    await _repository.saveCalculation(calculation);
  }
}