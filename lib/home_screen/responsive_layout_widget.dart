import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'language_box_widgets/home_body_desktop.dart';
import 'language_box_widgets/home_body_mobile.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const LanguageTranslationBodyMobile(),
      desktop: (_) => const LanguageTranslationBodyDesktop(),
    );
  }
}