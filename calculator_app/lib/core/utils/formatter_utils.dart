class FormatterUtils {
  static String formatNumber(String number) {
    if (number == 'Error' || number == 'Infinity' || number == 'NaN') {
      return 'Error';
    }
    
    try {
      final parsed = double.parse(number);
      
      if (parsed.isInfinite || parsed.isNaN) {
        return 'Error';
      }
      
      final parts = number.split('.');
      final integerPart = parts[0];
      final decimalPart = parts.length > 1 ? '.${parts[1]}' : '';
      
      final formattedInteger = integerPart.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]}.',
      );
      
      String formattedDecimal = decimalPart;
      if (decimalPart.length > 11) {
        formattedDecimal = decimalPart.substring(0, 11);
      }
      
      return formattedInteger + formattedDecimal;
    } catch (e) {
      return number;
    }
  }
  
  static String formatExpression(String expression) {
    return expression.trim();
  }
  
  static String removeFormatting(String formattedNumber) {
    return formattedNumber.replaceAll('.', '');
  }
}