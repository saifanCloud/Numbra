import '../../domain/entities/calculation_entity.dart';

class CalculationModel extends CalculationEntity {
  const CalculationModel({
    required super.id,
    required super.expression,
    required super.result,
    required super.timestamp,
  });
  
  factory CalculationModel.fromJson(Map<String, dynamic> json) {
    return CalculationModel(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      expression: json['expression'] ?? '',
      result: json['result'] ?? '0',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
    };
  }
  
  factory CalculationModel.fromEntity(CalculationEntity entity) {
    return CalculationModel(
      id: entity.id,
      expression: entity.expression,
      result: entity.result,
      timestamp: entity.timestamp,
    );
  }
}