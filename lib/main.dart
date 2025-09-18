import 'package:flutter/material.dart';
import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/modules/home/presentation/pages/home_page.dart';
import 'app/themes/theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final projectId = dotenv.env['CLARITY_PROJECT_ID'] ?? 'CLARITY_PROJECT_ID';

  final config = ClarityConfig(
    projectId: projectId,
    logLevel: LogLevel.Verbose,
  );

  runApp(ClarityWidget(
    app: const MyApp(),
    clarityConfig: config,
  ));
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
