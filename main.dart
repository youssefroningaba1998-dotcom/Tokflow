import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/auth_gate.dart';
import 'services/app_state.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool firebaseReady = false;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseReady = true;
  } catch (_) {
    // L'application reste lançable en mode démo tant que Firebase
    // n'est pas configuré avec flutterfire configure.
  }

  runApp(TokFlowApp(firebaseReady: firebaseReady));
}

class TokFlowApp extends StatelessWidget {
  final bool firebaseReady;

  const TokFlowApp({super.key, required this.firebaseReady});

  @override
  Widget build(BuildContext context) {
    return AppState(
      firebaseReady: firebaseReady,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TokFlow',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        home: const AuthGate(),
      ),
    );
  }
}
