import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/modules/home/presentation/pages/home_page.dart';
import 'app/themes/theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");

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
