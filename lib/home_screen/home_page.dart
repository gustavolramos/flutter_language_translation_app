import 'package:flutter/material.dart';
import 'package:riverpod_language_translate/home_screen/responsive_layout_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Expanded(
              child: ResponsiveLayout()
          ),
        ],
      ),
    );
  }
}