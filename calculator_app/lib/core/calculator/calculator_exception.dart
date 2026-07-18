class DivisionByZeroException implements Exception {
  final String message = 'Cannot divide by zero';
  
  @override
  String toString() => message;
}

class InvalidInputException implements Exception {
  final String input;
  
  InvalidInputException(this.input);
  
  @override
  String toString() => 'Invalid input: $input';
}