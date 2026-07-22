import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Mengimpor library Flutter Material dan Services untuk efek getaran sentuhan (haptic feedback).



class NeumorphicButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isOperator;
  final bool isFunction;
  final bool isWide;
  final bool isDark;
  final double size;
  final double fontSize;
  final double gap;

  const NeumorphicButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOperator = false,
    this.isFunction = false,
    this.isWide = false,
    required this.isDark,
    required this.size,
    required this.fontSize,
    this.gap = 12.0,
  });

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}
// StatefullWidget NeumorphicButton untuk membuat efek visual tombol 3D lembut yang timbul dan amples saat ditekan.



class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }
// Mengelola status animasi saat tombol sedang disentuh, dilepas, atau dibatalkan oleh pengguna.



  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color lightShadowColor;
    Color darkShadowColor;

    if (widget.isOperator) {
      bgColor = const Color(0xFFFFA827);
      textColor = Colors.white;
      lightShadowColor = const Color(0xFFFFBF58);
      darkShadowColor = const Color(0xFFCC8011);
    } else if (widget.isFunction) {
      bgColor = widget.isDark ? const Color(0xFFE2E7ED) : const Color(0xFFE0E5EC);
      textColor = const Color(0xFF7F8C9D);
      lightShadowColor = widget.isDark ? const Color(0x20FFFFFF) : const Color(0xFFFFFFFF);
      darkShadowColor = widget.isDark ? const Color(0x302A384F) : const Color(0xFFB8C4D9);
    } else {
      bgColor = widget.isDark ? const Color(0xFF384B66) : const Color(0xFFF1F3F6);
      textColor = widget.isDark ? Colors.white : const Color(0xFF4E5E72);
      lightShadowColor = widget.isDark ? const Color(0xFF455B7C) : const Color(0xFFFFFFFF);
      darkShadowColor = widget.isDark ? const Color(0xFF2A384F) : const Color(0xFFD1D9E6);
    }
// Penentuan warna latar, teks, serta bayangan cerah dan gelap sesuai dengan kategori tombol dan mode tema.



    final double offsetVal = _isPressed ? 1.5 : 5.0;
    final double blurVal = _isPressed ? 3.0 : 10.0;
    final double shadowOpacity = _isPressed ? 0.6 : 0.9;

    final width = widget.isWide ? (widget.size * 2) + widget.gap : widget.size;
    final height = widget.size;
    final borderRadius = BorderRadius.circular(height / 2);
// Perhitungan offset bayangan visual Neumorphism untuk efek tombol tertekan ke dalam (inset dynamic look).



    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onPressed();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: _isPressed 
              ? (widget.isOperator 
                  ? const Color(0xFFE5941B) 
                  : (widget.isFunction 
                      ? (widget.isDark ? const Color(0xFFD5DCE4) : const Color(0xFFD2D8DF))
                      : (widget.isDark ? const Color(0xFF2F3F56) : const Color(0xFFE5E9EF))))
              : bgColor,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: lightShadowColor.withValues(alpha: shadowOpacity),
              offset: Offset(-offsetVal, -offsetVal),
              blurRadius: blurVal,
            ),
            BoxShadow(
              color: darkShadowColor.withValues(alpha: shadowOpacity),
              offset: Offset(offsetVal, offsetVal),
              blurRadius: blurVal,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: widget.isOperator 
                  ? FontWeight.w600 
                  : (widget.isFunction ? FontWeight.w500 : FontWeight.w400),
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
// Rendering container tombol teranimasi beserta efek ganda bayangan Neumorphic (cahaya kiri-atas dan bayangan kanan-bawah).
}
