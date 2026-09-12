import 'package:flutter/material.dart';

import '../screens/detail_screen.dart';
import '../widgets/pricing_card.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Data model sederhana untuk setiap paket layanan IT
// ─────────────────────────────────────────────────────────────────────────────
class PackageData {
  final String packageName;
  final String description;
  final String price;
  final String duration;
  final List<String> features;
  final List<String> detailFeatures;
  final IconData icon;
  final String? badgeText;

  const PackageData({
    required this.packageName,
    required this.description,
    required this.price,
    required this.duration,
    required this.features,
    required this.detailFeatures,
    required this.icon,
    this.badgeText,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Screen 1 — Beranda / Katalog (StatelessWidget sesuai requirement)
// ─────────────────────────────────────────────────────────────────────────────
class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  // Daftar 3 paket layanan IT — data terpusat di sini
  static const List<PackageData> _packages = [
    PackageData(
      packageName: 'Paket Pemula',
      description:
          'Layanan dasar untuk usaha kecil yang baru memulai kebutuhan digital. '
          'Cocok bagi Anda yang ingin hadir secara online dengan cepat dan terjangkau.',
      price: 'Rp 1.500.000',
      duration: '/ proyek',
      icon: Icons.smartphone,
      features: [
        '1 halaman landing page',
        'Desain modern & profesional',
        'Responsive HP & desktop',
        'Tombol WhatsApp / CTA',
      ],
      detailFeatures: [
        '1 halaman landing page',
        'Desain modern & profesional',
        'Responsive HP & desktop',
        'Tombol WhatsApp / CTA',
        'Form kontak',
        'Google Maps',
        'Optimasi tampilan dasar',
        'Request warna & konsep',
        'Revisi sesuai kesepakatan',
      ],
    ),
    PackageData(
      packageName: 'Paket Standar',
      description:
          'Layanan pengembangan website dan sistem ringan untuk operasional bisnis. '
          'Dirancang agar proses bisnis Anda berjalan lebih efisien secara digital.',
      price: 'Rp 3.000.000',
      duration: '/ proyek',
      icon: Icons.devices,
      features: [
        'Website profesional',
        'Domain & Hosting',
        'SSL / HTTPS',
        'Desain responsive',
      ],
      detailFeatures: [
        'Website profesional',
        'Domain',
        'Hosting',
        'SSL / HTTPS',
        'Desain responsive',
        'Home Page',
        'Tentang Kami',
        'Produk / Layanan',
        'Halaman Kontak',
        'Integrasi WhatsApp',
        'Google Maps',
        'Form kontak',
        'Galeri / portofolio',
        'SEO dasar',
        'WordPress',
      ],
    ),
    PackageData(
      packageName: 'Paket Profesional',
      description:
          'Layanan IT lengkap untuk bisnis yang membutuhkan dukungan stabil dan '
          'solusi teknologi yang skalabel sesuai pertumbuhan perusahaan Anda.',
      price: 'Rp 5.000.000',
      duration: '/ proyek',
      icon: Icons.laptop_mac,
      badgeText: 'Rekomendasi',
      features: [
        'Website profesional custom',
        'WordPress + Elementor',
        'Desain premium',
        'SEO On-Page dasar',
      ],
      detailFeatures: [
        'Website profesional custom',
        'Domain',
        'Hosting',
        'SSL / HTTPS',
        'WordPress + Elementor',
        'Desain premium',
        'Home Page',
        'About / Tentang Kami',
        'Produk / Layanan',
        'Detail Produk / Layanan',
        'Blog / Artikel',
        'Galeri / Portofolio',
        'Integrasi WhatsApp',
        'Google Maps',
        'Social Media Integration',
        'SEO On-Page dasar',
        'Google Search Console',
        'Google Analytics',
        'Optimasi mobile',
        'Konsultasi website',
      ],
    ),
  ];

  // Helper: navigasi ke Screen 2 menggunakan Navigator.push (Stack Navigation)
  void _navigateToDetail(BuildContext context, PackageData pkg) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          packageName: pkg.packageName,
          description: pkg.description,
          price: pkg.price,
          duration: pkg.duration,
          features: pkg.detailFeatures,
          icon: pkg.icon,
          badgeText: pkg.badgeText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),

      // AppBar wajib ada sesuai requirement
      appBar: AppBar(
        title: const Text('Pilih Paket Layanan IT Anda'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1D4ED8),
        foregroundColor: Colors.white,
      ),

      // Body: ListView berisi 3 item (sesuai requirement)
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        itemCount: _packages.length,
        itemBuilder: (context, index) {
          final pkg = _packages[index];
          return _CatalogItem(
            pkg: pkg,
            onTap: () => _navigateToDetail(context, pkg),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Widget item katalog:
//  - Menampilkan PricingCard dengan tombol "Lihat Detail"
// ─────────────────────────────────────────────────────────────────────────────
class _CatalogItem extends StatelessWidget {
  const _CatalogItem({required this.pkg, required this.onTap});

  final PackageData pkg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Center(
        child: PricingCard(
          packageName: pkg.packageName,
          description: pkg.description,
          price: pkg.price,
          duration: pkg.duration,
          icon: pkg.icon,
          badgeText: pkg.badgeText,
          features: pkg.features,
          buttonText: 'Lihat Detail',
          onPressed: onTap,
        ),
      ),
    );
  }
}
