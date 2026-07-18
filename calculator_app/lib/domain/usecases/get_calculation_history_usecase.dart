import '../repositories/i_calculation_repository.dart';

class ClearCalculationHistoryUseCase {
  final ICalculationRepository _repository;
  
  ClearCalculationHistoryUseCase(this._repository);
  
  Future<void> execute() async {
    await _repository.clearHistory();
  }
}