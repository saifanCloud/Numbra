class CalculationEntity {
  final String id;
  final String expression;
  final String result;
  final DateTime timestamp;
  
  const CalculationEntity({
    required this.id,
    required this.expression,
    required this.result,
    required this.timestamp,
  });
  
  @override
  String toString() {
    return '$expression = $result';
  }
}