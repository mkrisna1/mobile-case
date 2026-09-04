import 'package:flutter/material.dart';

import 'widgets/pricing_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PricingCardPage(),
    );
  }
}

class PricingCardPage extends StatelessWidget {
  const PricingCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('Pilih Paket Layanan IT Anda'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1D4ED8),
        foregroundColor: Colors.white,
      ),
      body: const SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: [
                PricingCard(
                  packageName: 'Paket Pemula',
                  description: 'Layanan dasar untuk usaha kecil yang baru memulai kebutuhan digital.',
                  price: 'Rp 1.500.000',
                  duration: '/ proyek',
                  icon: Icons.smartphone,
                  features: [
                    'Desain landing page sederhana',
                    'Setup halaman profil bisnis',
                    'Form kontak dasar',
                    'Dukungan teknis 7 hari',
                  ],
                ),
                PricingCard(
                  packageName: 'Paket Standar',
                  description: 'Layanan pengembangan website dan sistem ringan untuk operasional bisnis.',
                  price: 'Rp 3.000.000',
                  duration: '/ proyek',
                  icon: Icons.devices,
                  features: [
                    'Desain UI responsif',
                    'Setup database dasar',
                    'Integrasi form dan email',
                    'Dukungan teknis 14 hari',
                  ],
                ),
                PricingCard(
                  packageName: 'Paket Profesional',
                  description: 'Layanan IT lengkap untuk bisnis yang membutuhkan dukungan stabil.',
                  price: 'Rp 5.000.000',
                  duration: '/ proyek',
                  badgeText: 'Rekomendasi',
                  features: [
                    'Desain UI/UX khusus',
                    'Setup database',
                    'Integrasi API',
                    'Dukungan teknis 30 hari',
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
