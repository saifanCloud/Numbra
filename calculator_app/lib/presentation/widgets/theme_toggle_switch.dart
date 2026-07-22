import 'package:flutter/material.dart';
// Mengimpor library standar Flutter Material Design.



class ThemeToggleSwitch extends StatelessWidget {
  final bool isDark;
  final VoidCallback onTap;

  const ThemeToggleSwitch({
    super.key,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final trackColor = isDark ? const Color(0xFF2D3C52) : const Color(0xFFE2E6EC);
    final thumbColor = isDark ? Colors.white : const Color(0xFF2C3D52);
    final activeIconColor = isDark ? const Color(0xFF2C3D52) : Colors.white;
    final inactiveIconColor = isDark ? const Color(0xFF7A8EAB) : const Color(0xFF9AAEC4);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 76,
        height: 38,
        decoration: BoxDecoration(
          color: trackColor,
          borderRadius: BorderRadius.circular(19),
          boxShadow: [
            BoxShadow(
              color: isDark ? const Color(0x661E2938) : const Color(0x33A3B1C6),
              offset: const Offset(1, 2),
              blurRadius: 3,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 8,
              child: Opacity(
                opacity: isDark ? 0.0 : 1.0,
                child: Icon(
                  Icons.dark_mode,
                  size: 16,
                  color: inactiveIconColor,
                ),
              ),
            ),
// Ikon bulan di sebelah kiri rel sakelar yang aktif saat mode terang terpilih.



            Positioned(
              right: 8,
              child: Opacity(
                opacity: isDark ? 1.0 : 0.0,
                child: Icon(
                  Icons.wb_sunny,
                  size: 16,
                  color: inactiveIconColor,
                ),
              ),
            ),
// Ikon matahari di sebelah kanan rel sakelar yang aktif saat mode gelap terpilih.



            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: isDark ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: thumbColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? const Color(0x40000000) : const Color(0x33000000),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    isDark ? Icons.dark_mode : Icons.wb_sunny,
                    size: 16,
                    color: activeIconColor,
                  ),
                ),
              ),
            ),
// Tombol geser bulat (thumb) beranimasi yang berpindah posisi secara halus antara mode terang dan mode gelap.
          ],
        ),
      ),
    );
  }
// Widget pembungkus GestureDetector dan AnimatedContainer untuk seluruh komponen sakelar tema Neumorphism.
}
