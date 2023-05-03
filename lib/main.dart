import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen/home_page_widgets/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final boolProvider = Provider<bool>((ref) => false);

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool appProvider = ref.watch(boolProvider);
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: appProvider,
      theme: Theme.of(context)
          .copyWith(textTheme: GoogleFonts.openSansTextTheme()),
    );
  }
}