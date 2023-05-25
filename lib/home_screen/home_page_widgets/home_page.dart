import 'package:flutter/material.dart';
import 'package:language_translation_app/home_screen/home_page_widgets/responsive_layout_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          ResponsiveLayout(),
        ],
      ),
    );
  }
}