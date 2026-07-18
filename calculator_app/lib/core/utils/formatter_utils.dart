class FormatterUtils {
  static String formatNumber(String number) {
    if (number == 'Error' || number == 'Infinity' || number == 'NaN') {
      return 'Error';
    }
    
    try {
      final parsed = double.parse(number);
      
      // Handle special cases
      if (parsed.isInfinite || parsed.isNaN) {
        return 'Error';
      }
      
      // Format with thousand separators (Indonesian format: dots as thousand separator)
      final parts = number.split('.');
      final integerPart = parts[0];
      final decimalPart = parts.length > 1 ? '.${parts[1]}' : '';
      
      // Add thousand separators
      final formattedInteger = integerPart.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]}.',
      );
      
      // Limit decimal places to 10
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
    // Clean up expression for display
    return expression.trim();
  }
  
  // Additional formatting methods
  static String removeFormatting(String formattedNumber) {
    return formattedNumber.replaceAll('.', '');
  }
}