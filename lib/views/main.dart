import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'expenses/ExpenseScreen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
      MaterialApp(
        home: ExpenseScreen(),
      )
  );
}