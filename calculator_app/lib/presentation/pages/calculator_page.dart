import 'package:flutter/material.dart';
import '../../core/calculator/calculator_operation.dart';
import '../controllers/calculator_controller.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';
import '../widgets/history_panel.dart';

class CalculatorPage extends StatelessWidget {
  final CalculatorController controller;
  
  const CalculatorPage({
    super.key,
    required this.controller,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? Colors.black 
          : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // History Panel - fixed height
            Container(
              height: 100,
              child: HistoryPanel(
                history: controller.history,
                onClearHistory: controller.clearHistory,
                isLoading: controller.isLoading,
              ),
            ),
            // Display - expanded
            Expanded(
              flex: 1,
              child: CalculatorDisplay(
                expression: controller.expression,
                display: controller.display,
                isError: controller.isError,
              ),
            ),
            // Keypad - expanded with flexible height
            Expanded(
              flex: 2,
              child: CalculatorKeypad(
                onClearAll: controller.clearAll,
                onClear: controller.clear,
                onBackspace: controller.backspace,
                onPercentage: controller.calculatePercentage,
                onToggleSign: controller.toggleSign,
                onDivide: () => controller.inputOperator(CalculatorOperation.divide),
                onMultiply: () => controller.inputOperator(CalculatorOperation.multiply),
                onSubtract: () => controller.inputOperator(CalculatorOperation.subtract),
                onAdd: () => controller.inputOperator(CalculatorOperation.add),
                onEquals: controller.calculate,
                onDecimal: controller.inputDecimal,
                onNumber: controller.inputNumber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}