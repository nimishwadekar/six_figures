import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'services/hive_service.dart';
import 'stitch_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Six Figures',
      theme: AppTheme.light,
      home: const SereneLedgerShell(),
    );
  }
}
