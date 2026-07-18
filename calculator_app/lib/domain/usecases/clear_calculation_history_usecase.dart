import '../entities/calculation_entity.dart';
import '../repositories/i_calculation_repository.dart';

class GetCalculationHistoryUseCase {
  final ICalculationRepository _repository;
  
  GetCalculationHistoryUseCase(this._repository);
  
  Future<List<CalculationEntity>> execute() async {
    return await _repository.getHistory();
  }
}