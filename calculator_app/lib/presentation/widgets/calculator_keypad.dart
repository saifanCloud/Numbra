import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorKeypad extends StatelessWidget {
  final VoidCallback onClearAll;
  final VoidCallback onClear;
  final VoidCallback onBackspace;
  final VoidCallback onPercentage;
  final VoidCallback onToggleSign;
  final VoidCallback onDivide;
  final VoidCallback onMultiply;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;
  final VoidCallback onEquals;
  final VoidCallback onDecimal;
  final Function(String) onNumber;
  
  const CalculatorKeypad({
    super.key,
    required this.onClearAll,
    required this.onClear,
    required this.onBackspace,
    required this.onPercentage,
    required this.onToggleSign,
    required this.onDivide,
    required this.onMultiply,
    required this.onSubtract,
    required this.onAdd,
    required this.onEquals,
    required this.onDecimal,
    required this.onNumber,
  });
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Hitung ukuran tombol berdasarkan lebar layar
        final buttonSize = (constraints.maxWidth - 40) / 4;
        final fontSize = buttonSize * 0.4;
        
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Row 1: AC, ±, %, ÷
              Expanded(
                child: Row(
                  children: [
                    _buildButton(context, 'AC', onClearAll, buttonSize, fontSize, isFunction: true),
                    _buildButton(context, '±', onToggleSign, buttonSize, fontSize, isFunction: true),
                    _buildButton(context, '%', onPercentage, buttonSize, fontSize, isFunction: true),
                    _buildButton(context, '÷', onDivide, buttonSize, fontSize, isOperator: true),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Row 2: 7, 8, 9, ×
              Expanded(
                child: Row(
                  children: [
                    _buildButton(context, '7', () => onNumber('7'), buttonSize, fontSize),
                    _buildButton(context, '8', () => onNumber('8'), buttonSize, fontSize),
                    _buildButton(context, '9', () => onNumber('9'), buttonSize, fontSize),
                    _buildButton(context, '×', onMultiply, buttonSize, fontSize, isOperator: true),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Row 3: 4, 5, 6, -
              Expanded(
                child: Row(
                  children: [
                    _buildButton(context, '4', () => onNumber('4'), buttonSize, fontSize),
                    _buildButton(context, '5', () => onNumber('5'), buttonSize, fontSize),
                    _buildButton(context, '6', () => onNumber('6'), buttonSize, fontSize),
                    _buildButton(context, '-', onSubtract, buttonSize, fontSize, isOperator: true),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Row 4: 1, 2, 3, +
              Expanded(
                child: Row(
                  children: [
                    _buildButton(context, '1', () => onNumber('1'), buttonSize, fontSize),
                    _buildButton(context, '2', () => onNumber('2'), buttonSize, fontSize),
                    _buildButton(context, '3', () => onNumber('3'), buttonSize, fontSize),
                    _buildButton(context, '+', onAdd, buttonSize, fontSize, isOperator: true),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Row 5: 0 (wide), ., =
              Expanded(
                child: Row(
                  children: [
                    _buildButton(context, '0', () => onNumber('0'), buttonSize, fontSize, isWide: true),
                    _buildButton(context, '.', onDecimal, buttonSize, fontSize),
                    _buildButton(context, '=', onEquals, buttonSize, fontSize, isEquals: true),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
    double size,
    double fontSize, {
    bool isOperator = false,
    bool isFunction = false,
    bool isEquals = false,
    bool isWide = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color? bgColor;
    Color? textColor;
    
    if (isEquals) {
      bgColor = const Color(0xFF4A6CF7);
      textColor = Colors.white;
    } else if (isOperator) {
      bgColor = Colors.orange;
      textColor = Colors.white;
    } else if (isFunction) {
      bgColor = isDark ? Colors.grey[700] : Colors.grey[300];
      textColor = isDark ? Colors.white : Colors.black;
    } else {
      bgColor = isDark ? Colors.grey[800] : Colors.grey[200];
      textColor = isDark ? Colors.white : Colors.black;
    }
    
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: isWide ? (size * 2) + 4 : size,
        height: size,
        child: Material(
          color: bgColor,
          borderRadius: BorderRadius.circular(size / 2),
          child: InkWell(
            borderRadius: BorderRadius.circular(size / 2),
            onTap: () {
              HapticFeedback.lightImpact();
              onPressed();
            },
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}