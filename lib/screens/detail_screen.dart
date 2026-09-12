import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Screen 2 (Detail Katalog) — wajib StatefulWidget
// karena ada perubahan state interaktif pada tombol
class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.packageName,
    required this.description,
    required this.price,
    required this.duration,
    required this.features,
    required this.icon,
    this.badgeText,
  });

  final String packageName;
  final String description;
  final String price;
  final String duration;
  final List<String> features;
  final IconData icon;
  final String? badgeText;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

// --- Warna tema --- mengikuti beranda (biru #1D4ED8 / #2563EB) ---
const _kPrimary = Color(0xFF1D4ED8);
const _kAccent = Color(0xFF2563EB);
const _kBg = Color(0xFFF3F4F6);
const _kText = Color(0xFF111827);
const _kSubtext = Color(0xFF6B7280);
const _kCheckBg = Color(0xFFEFF6FF);
const _kCheckIcon = Color(0xFF2563EB);
const _kReviewBg = Color(0xFFEFF6FF);
const _kGold = Color(0xFFFACC15);

// Ulasan dummy untuk seksi "Ulasan Pengguna"
const _kReviews = [
  _Review(name: 'Arif Budiman',  stars: 5, comment: '"Hasilnya memuaskan dan pengerjaan cepat."'),
  _Review(name: 'Siti Rahayu',   stars: 5, comment: '"Sangat detail dan profesional. Direkomendasikan!"'),
];

class _Review {
  final String name;
  final int stars;
  final String comment;
  const _Review({required this.name, required this.stars, required this.comment});
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isOrdered = false;
  bool _isFavorite = false;

  void _toggleOrder() {
    setState(() => _isOrdered = !_isOrdered);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isOrdered
              ? 'Paket ${widget.packageName} berhasil dipesan!'
              : 'Pemesanan ${widget.packageName} dibatalkan.',
        ),
        backgroundColor: _isOrdered ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return Scaffold(
      backgroundColor: _kBg,
      bottomNavigationBar: _buildBottomBar(),
      body: CustomScrollView(
        slivers: [
          // --- SliverAppBar dengan hero gradient biru ---
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: _kPrimary,
            foregroundColor: Colors.white,
            leading: _CircleButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: () => Navigator.pop(context),
            ),
            actions: [
              _CircleButton(
                icon: _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                iconColor: _isFavorite ? Colors.redAccent : Colors.white,
                onTap: () => setState(() => _isFavorite = !_isFavorite),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -40,
                    right: -40,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.15),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                          ),
                          child: Icon(widget.icon, size: 48, color: Colors.white),
                        ),
                        if (widget.badgeText != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                            decoration: BoxDecoration(
                              color: _kGold,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              widget.badgeText!,
                              style: const TextStyle(
                                color: Color(0xFF713F12),
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Konten utama ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Nama, Rating, Harga, Durasi ---
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.packageName,
                          style: const TextStyle(
                            color: _kText,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: _kGold, size: 18),
                            const SizedBox(width: 4),
                            const Text(
                              '4.8',
                              style: TextStyle(color: _kText, fontSize: 13, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '(230 ulasan)',
                              style: TextStyle(color: _kSubtext, fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.price,
                              style: const TextStyle(color: _kAccent, fontSize: 24, fontWeight: FontWeight.w900),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: _kCheckBg,
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(color: const Color(0xFFBFDBFE)),
                              ),
                              child: Text(
                                'Durasi: ${widget.duration}',
                                style: const TextStyle(color: _kAccent, fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // --- Deskripsi Layanan ---
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Deskripsi Layanan',
                          style: TextStyle(color: _kText, fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.description,
                          style: const TextStyle(color: _kSubtext, fontSize: 14, height: 1.6),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // --- Termasuk / Fitur ---
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Termasuk:',
                          style: TextStyle(color: _kText, fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 12),
                        for (final feature in widget.features) ...[
                          _FeatureRow(feature: feature),
                          const SizedBox(height: 10),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // --- Ulasan Pengguna ---
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Ulasan Pengguna',
                              style: TextStyle(color: _kText, fontSize: 15, fontWeight: FontWeight.w800),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Lihat Semua >',
                                style: TextStyle(color: _kAccent, fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        for (final review in _kReviews) ...[
                          _ReviewCard(review: review),
                          const SizedBox(height: 8),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ESTIMASI TOTAL',
                  style: TextStyle(color: _kSubtext, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.price,
                  style: const TextStyle(color: _kText, fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _toggleOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isOrdered ? const Color(0xFFDC2626) : _kPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Text(
                _isOrdered ? 'Batalkan' : 'Pesan Sekarang',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Widget helper: kartu section putih dengan shadow ---
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// --- Widget helper: baris fitur dengan checklist biru ---
class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.feature});
  final String feature;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: _kCheckBg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.check_rounded, color: _kCheckIcon, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(feature, style: const TextStyle(color: _kText, fontSize: 14, height: 1.4)),
        ),
      ],
    );
  }
}

// --- Widget helper: kartu ulasan pengguna ---
class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final _Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kReviewBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(review.name, style: const TextStyle(color: _kText, fontSize: 13, fontWeight: FontWeight.w700)),
              const Spacer(),
              Row(
                children: List.generate(
                  review.stars,
                  (_) => const Icon(Icons.star_rounded, color: _kGold, size: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(review.comment, style: const TextStyle(color: _kSubtext, fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}

// --- Widget helper: tombol bulat transparan di atas hero ---
class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap, this.iconColor});
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.25),
        ),
        child: Icon(icon, color: iconColor ?? Colors.white, size: 18),
      ),
    );
  }
}

