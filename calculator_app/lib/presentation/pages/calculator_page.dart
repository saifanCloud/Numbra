import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/calculator/calculator_operation.dart';
import '../controllers/calculator_controller.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';
import '../widgets/history_panel.dart';
import '../widgets/theme_toggle_switch.dart';
// Mengimpor library Flutter dan widget UI internal yang dibutuhkan oleh halaman kalkulator utama.



class CalculatorPage extends StatefulWidget {
  final CalculatorController controller;

  const CalculatorPage({
    super.key,
    required this.controller,
  });

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}
// Widget utama CalculatorPage yang bersifat Stateful untuk mengelola tampilan kalkulator dan status overlay riwayat.



class _CalculatorPageState extends State<CalculatorPage> {
  bool _showHistory = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.controller.isDarkTheme;
    final backgroundColor = isDark ? const Color(0xFF384B66) : const Color(0xFFF1F3F6);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ThemeToggleSwitch(
                        isDark: isDark,
                        onTap: widget.controller.toggleTheme,
                      ),
                      _buildHistoryButton(isDark),
                    ],
                  ),
                ),
// Header atas yang memuat tombol pengubah tema (gelap/terang) dan tombol pembuka panel riwayat.



                Expanded(
                  flex: 3,
                  child: CalculatorDisplay(
                    expression: widget.controller.expression,
                    display: widget.controller.display,
                    isError: widget.controller.isError,
                  ),
                ),
// Bagian layar utama (display) yang menampilkan ekspresi hitungan dan hasil angka kalkulator.



                Expanded(
                  flex: 7,
                  child: CalculatorKeypad(
                    onClearAll: widget.controller.clearAll,
                    onClear: widget.controller.clear,
                    onBackspace: widget.controller.backspace,
                    onPercentage: widget.controller.calculatePercentage,
                    onToggleSign: widget.controller.toggleSign,
                    onDivide: () => widget.controller.inputOperator(CalculatorOperation.divide),
                    onMultiply: () => widget.controller.inputOperator(CalculatorOperation.multiply),
                    onSubtract: () => widget.controller.inputOperator(CalculatorOperation.subtract),
                    onAdd: () => widget.controller.inputOperator(CalculatorOperation.add),
                    onEquals: widget.controller.calculate,
                    onDecimal: widget.controller.inputDecimal,
                    onNumber: widget.controller.inputNumber,
                  ),
                ),
// Bagian papan tombol (keypad) yang berisi seluruh tombol angka dan fungsi matematika.
              ],
            ),



            if (_showHistory) ...[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showHistory = false;
                  });
                },
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: 1.0,
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.3),
                  ),
                ),
              ),
// Backdrop hitam transparan yang merespons sentuhan luar untuk menutup panel riwayat.



              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                top: _showHistory ? 0 : -MediaQuery.of(context).size.height,
                left: 0,
                right: 0,
                bottom: 0,
                child: HistoryPanel(
                  history: widget.controller.history,
                  onClearHistory: widget.controller.clearHistory,
                  onClose: () {
                    setState(() {
                      _showHistory = false;
                    });
                  },
                  isLoading: widget.controller.isLoading,
                  isDark: isDark,
                ),
              ),
// Panel overlay riwayat perhitungan yang meluncur dari atas layar dengan animasi halus.
            ],
          ],
        ),
      ),
    );
  }



  Widget _buildHistoryButton(bool isDark) {
    final bgColor = isDark ? const Color(0xFF384B66) : const Color(0xFFF1F3F6);
    final iconColor = isDark ? Colors.white : const Color(0xFF4E5E72);
    final lightShadow = isDark ? const Color(0xFF455B7C) : const Color(0xFFFFFFFF);
    final darkShadow = isDark ? const Color(0xFF2A384F) : const Color(0xFFD1D9E6);

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          _showHistory = true;
        });
      },
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: lightShadow.withValues(alpha: 0.9),
              offset: const Offset(-3, -3),
              blurRadius: 6,
            ),
            BoxShadow(
              color: darkShadow.withValues(alpha: 0.9),
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Icon(
          Icons.history,
          size: 18,
          color: iconColor,
        ),
      ),
    );
  }
// Helper widget untuk membuat tombol ikon riwayat Neumorphism melingkar dengan feedback getar sentuhan.
}