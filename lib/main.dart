import 'package:flutter/material.dart';
import 'package:ghibli_dex/app/modules/movies/presentation/pages/home_page.dart';
import 'app/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GhibliDex',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: HomePage(),
    );
  }
}
