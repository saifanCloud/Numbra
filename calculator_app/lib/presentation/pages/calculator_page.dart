import 'package:flutter/material.dart';
import '../../core/calculator/calculator_engine.dart';
import '../../core/calculator/calculator_operation.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorEngine _engine = CalculatorEngine();

  void _updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _engine.expression,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _engine.display,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: _engine.isError ? Colors.red : Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            
            // Keypad
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  // Row 1: AC, ±, %, ÷
                  Row(
                    children: [
                      _buildButton('AC', Colors.grey[700]!, Colors.black,
                          () => _engine.clearAll(), _updateUI),
                      _buildButton('±', Colors.grey[700]!, Colors.black,
                          () => _engine.toggleSign(), _updateUI),
                      _buildButton('%', Colors.grey[700]!, Colors.black,
                          () => _engine.percentage(), _updateUI),
                      _buildButton('÷', Colors.orange, Colors.white,
                          () => _engine.inputOperator(CalculatorOperation.divide), _updateUI),
                    ],
                  ),
                  // Row 2: 7, 8, 9, ×
                  Row(
                    children: [
                      _buildNumberButton('7', _updateUI),
                      _buildNumberButton('8', _updateUI),
                      _buildNumberButton('9', _updateUI),
                      _buildButton('×', Colors.orange, Colors.white,
                          () => _engine.inputOperator(CalculatorOperation.multiply), _updateUI),
                    ],
                  ),
                  // Row 3: 4, 5, 6, -
                  Row(
                    children: [
                      _buildNumberButton('4', _updateUI),
                      _buildNumberButton('5', _updateUI),
                      _buildNumberButton('6', _updateUI),
                      _buildButton('-', Colors.orange, Colors.white,
                          () => _engine.inputOperator(CalculatorOperation.subtract), _updateUI),
                    ],
                  ),
                  // Row 4: 1, 2, 3, +
                  Row(
                    children: [
                      _buildNumberButton('1', _updateUI),
                      _buildNumberButton('2', _updateUI),
                      _buildNumberButton('3', _updateUI),
                      _buildButton('+', Colors.orange, Colors.white,
                          () => _engine.inputOperator(CalculatorOperation.add), _updateUI),
                    ],
                  ),
                  // Row 5: 0 (wide), ., =
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildButton('0', Colors.grey[800]!, Colors.white,
                            () => _engine.inputNumber('0'), _updateUI),
                      ),
                      Expanded(
                        child: _buildButton('.', Colors.grey[800]!, Colors.white,
                            () => _engine.inputDecimal(), _updateUI),
                      ),
                      Expanded(
                        child: _buildButton('=', Colors.orange, Colors.white,
                            () => _engine.calculate(), _updateUI),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number, VoidCallback updateUI) {
    return Expanded(
      child: _buildButton(
        number,
        Colors.grey[800]!,
        Colors.white,
        () => _engine.inputNumber(number),
        updateUI,
      ),
    );
  }

  Widget _buildButton(
    String label,
    Color bgColor,
    Color textColor,
    VoidCallback onPressed,
    VoidCallback updateUI,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(40),
        child: InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            onPressed();
            updateUI();
          },
          child: Container(
            height: 70,
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}