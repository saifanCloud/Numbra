import 'package:flutter/material.dart';
// Mengimpor paket dasar Material UI dari Flutter.



class CalculatorDisplay extends StatelessWidget {
  final String expression;
  final String display;
  final bool isError;
  
  const CalculatorDisplay({
    super.key,
    required this.expression,
    required this.display,
    this.isError = false,
  });
// Widget StatelessWidget CalculatorDisplay untuk menampilkan teks matematika ekspresi dan hasil output kalkulator.



  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final expressionColor = isDark ? const Color(0xFF7B8D9E) : const Color(0xFF9AAEC4);
    final displayColor = isError 
        ? Colors.redAccent 
        : (isDark ? Colors.white : const Color(0xFF4E5E72));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (expression.isNotEmpty)
            Text(
              expression,
              style: TextStyle(
                fontSize: 20,
                color: expressionColor,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
// Komponen teks untuk ekspresi matematika yang sedang berjalan (contoh: 12 + 5 * 2).



          const SizedBox(height: 8),
// Beri jarak vertikal sebesar 8 piksel antara ekspresi dan nilai angka utama.



          Text(
            display,
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w400,
              color: displayColor,
              letterSpacing: 0.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
// Komponen teks utama berukuran besar untuk menampilkan angka input atau hasil kalkulasi akhir.
        ],
      ),
    );
  }
// Method build untuk menyusun tata letak area layar kalkulator secara responsif ke kanan bawah.
}
