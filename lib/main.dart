import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen/home_page_widgets/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        textTheme: GoogleFonts.openSansTextTheme()
      ),
    );
  }
}