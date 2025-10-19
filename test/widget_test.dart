import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumaia_project/main.dart';

void main() {
  testWidgets('App starts and shows RUMAIA title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our app starts and shows the RUMAIA text
    expect(find.text('RUMAIA'), findsOneWidget);
    expect(find.text('Find Your Dream Home'), findsOneWidget);
  });

  testWidgets('Bottom navigation has 5 items', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verify that bottom navigation bar has 5 items
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // You can also check for specific navigation items
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Properti'), findsOneWidget);
    expect(find.text('Ajukan'), findsOneWidget);
    expect(find.text('Pengajuan'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);
  });

  testWidgets('Home screen has search bar and promo section', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp());

    // Verify search bar is present
    expect(find.text('Cari lokasi, tipe rumah...'), findsOneWidget);

    // Verify promo section is present
    expect(find.text('Promo Akhir Tahun'), findsOneWidget);
    expect(find.text('Diskon hingga 20% untuk rumah pilihan'), findsOneWidget);
  });
}
