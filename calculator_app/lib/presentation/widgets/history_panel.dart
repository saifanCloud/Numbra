import 'package:flutter/material.dart';
import '../../domain/entities/calculation_entity.dart';
// Mengimpor SDK UI Flutter dan entity data riwayat perhitungan (CalculationEntity).



class HistoryPanel extends StatelessWidget {
  final List<CalculationEntity> history;
  final VoidCallback onClearHistory;
  final VoidCallback onClose;
  final bool isLoading;
  final bool isDark;

  const HistoryPanel({
    super.key,
    required this.history,
    required this.onClearHistory,
    required this.onClose,
    required this.isLoading,
    required this.isDark,
  });
// Widget StatelessWidget HistoryPanel untuk menampilkan kartu overlay riwayat kalkulasi sebelumnya.



  @override
  Widget build(BuildContext context) {
    final cardColor = isDark ? const Color(0xFF384B66) : const Color(0xFFF1F3F6);
    final textColor = isDark ? Colors.white : const Color(0xFF4E5E72);
    final subTextColor = isDark ? const Color(0xFF7B8D9E) : const Color(0xFF9AAEC4);
    
    final lightShadowColor = isDark ? const Color(0xFF455B7C) : const Color(0xFFFFFFFF);
    final darkShadowColor = isDark ? const Color(0xFF2A384F) : const Color(0xFFD1D9E6);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 80, 16, 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: darkShadowColor.withValues(alpha: 0.8),
            offset: const Offset(6, 6),
            blurRadius: 16,
          ),
          BoxShadow(
            color: lightShadowColor.withValues(alpha: 0.8),
            offset: const Offset(-6, -6),
            blurRadius: 16,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  Row(
                    children: [
                      if (history.isNotEmpty)
                        TextButton(
                          onPressed: onClearHistory,
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          ),
                          child: const Text(
                            'Clear All',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.close, color: textColor),
                        onPressed: onClose,
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
// Bagian judul panel 'History' beserta tombol 'Clear All' untuk menghapus semua riwayat dan tombol tutup (X).



            Container(
              height: 1,
              color: isDark ? const Color(0xFF2D3C52) : const Color(0xFFE2E6EC),
            ),
// Garis pembatas horizontal tipis antara bagian header dan isi daftar riwayat.



            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : history.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.history,
                                size: 48,
                                color: subTextColor,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'No calculations yet',
                                style: TextStyle(
                                  color: subTextColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            final calculation = history[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    calculation.expression,
                                    style: TextStyle(
                                      color: subTextColor,
                                      fontSize: 14,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    calculation.result,
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    height: 1,
                                    color: isDark 
                                        ? const Color(0xFF2D3C52).withValues(alpha: 0.3) 
                                        : const Color(0xFFE2E6EC).withValues(alpha: 0.5),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
// Konten daftar riwayat kalkulasi yang dapat di-scroll, lengkap dengan penanganan indikator loading dan status kosong.
          ],
        ),
      ),
    );
  }
// Method build untuk menyusun kartu mengambang berdesain Neumorphic bergaya glassmorphism lembut.
}