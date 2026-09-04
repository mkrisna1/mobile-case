// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_pertama/main.dart';

void main() {
  testWidgets('Menampilkan daftar kartu harga layanan IT', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text('Paket Pemula'), findsOneWidget);
    expect(find.text('Paket Standar'), findsOneWidget);
    expect(find.text('Paket Profesional'), findsOneWidget);
    expect(find.text('Rp 1.500.000'), findsOneWidget);
    expect(find.text('Rp 3.000.000'), findsOneWidget);
    expect(find.text('Rp 5.000.000'), findsOneWidget);
    expect(find.text('/ proyek'), findsNWidgets(3));
    expect(find.text('Rekomendasi'), findsOneWidget);
    expect(find.text('Pilih Paket'), findsNWidgets(3));
    expect(find.byIcon(Icons.check_circle), findsNWidgets(12));
  });
}
