import 'package:flutter/material.dart';
import 'neumorphic_button.dart';
// Mengimpor Flutter Material SDK dan komponen tombol kustom NeumorphicButton.



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
// Deklarasi properti callback aksi tombol yang diterima oleh komponen keypad kalkulator.



  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxButtonWidth = (constraints.maxWidth - 32.0 - 36.0) / 4;
        final double maxButtonHeight = (constraints.maxHeight - 16.0 - 48.0) / 5;
        final double buttonSize = (maxButtonWidth < maxButtonHeight ? maxButtonWidth : maxButtonHeight).clamp(10.0, 120.0);
        final double fontSize = buttonSize * 0.32;
        final double gap = (constraints.maxWidth - 32.0 - (4 * buttonSize)) / 3;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicButton(
                    label: 'AC',
                    onPressed: onClearAll,
                    isFunction: true,
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize * 0.9,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '+/-',
                    onPressed: onToggleSign,
                    isFunction: true,
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize * 0.9,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '<-',
                    onPressed: onBackspace,
                    isFunction: true,
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize * 0.9,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '/',
                    onPressed: onDivide,
                    isOperator: true,
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                ],
              ),
// Baris tombol 1: Menampilkan fungsi AC (Clear All), +/- (Toggle Sign), Backspace (<-), dan Pembagian (/).



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicButton(
                    label: '7',
                    onPressed: () => onNumber('7'),
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '8',
                    onPressed: () => onNumber('8'),
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '9',
                    onPressed: () => onNumber('9'),
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: 'X',
                    onPressed: onMultiply,
                    isOperator: true,
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                ],
              ),
// Baris tombol 2: Menampilkan angka 7, 8, 9, dan operator Perkalian (X).



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicButton(
                    label: '4',
                    onPressed: () => onNumber('4'),
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '5',
                    onPressed: () => onNumber('5'),
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '6',
                    onPressed: () => onNumber('6'),
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '-',
                    onPressed: onSubtract,
                    isOperator: true,
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                ],
              ),
// Baris tombol 3: Menampilkan angka 4, 5, 6, dan operator Pengurangan (-).



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicButton(
                    label: '1',
                    onPressed: () => onNumber('1'),
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '2',
                    onPressed: () => onNumber('2'),
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '3',
                    onPressed: () => onNumber('3'),
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '+',
                    onPressed: onAdd,
                    isOperator: true,
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                ],
              ),
// Baris tombol 4: Menampilkan angka 1, 2, 3, dan operator Penjumlahan (+).



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicButton(
                    label: '0',
                    onPressed: () => onNumber('0'),
                    isWide: true,
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '.',
                    onPressed: onDecimal,
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                  NeumorphicButton(
                    label: '=',
                    onPressed: onEquals,
                    isOperator: true,
                    isDark: isDark,
                    size: buttonSize,
                    fontSize: fontSize,
                    gap: gap,
                  ),
                ],
              ),
// Baris tombol 5: Menampilkan angka 0 (lebar ganda), desimal (.), dan sama dengan (=).
            ],
          ),
        );
      },
    );
  }
// Method build untuk menghitung dimensi tombol secara dinamis dan menyusun kisi-kisi tombol kalkulator.
}
