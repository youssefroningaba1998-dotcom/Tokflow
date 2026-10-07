// Ce fichier est volontairement un modèle.
// Après création de ton projet Firebase, exécute:
//   dart pub global activate flutterfire_cli
//   flutterfire configure
// La commande remplacera/générera ce fichier avec les vraies options.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: 'CONFIGURE_WITH_FLUTTERFIRE',
        appId: 'CONFIGURE_WITH_FLUTTERFIRE',
        messagingSenderId: 'CONFIGURE_WITH_FLUTTERFIRE',
        projectId: 'CONFIGURE_WITH_FLUTTERFIRE',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: 'CONFIGURE_WITH_FLUTTERFIRE',
          appId: 'CONFIGURE_WITH_FLUTTERFIRE',
          messagingSenderId: 'CONFIGURE_WITH_FLUTTERFIRE',
          projectId: 'CONFIGURE_WITH_FLUTTERFIRE',
        );
      case TargetPlatform.iOS:
        return const FirebaseOptions(
          apiKey: 'CONFIGURE_WITH_FLUTTERFIRE',
          appId: 'CONFIGURE_WITH_FLUTTERFIRE',
          messagingSenderId: 'CONFIGURE_WITH_FLUTTERFIRE',
          projectId: 'CONFIGURE_WITH_FLUTTERFIRE',
          iosBundleId: 'com.example.tokflow',
        );
      default:
        throw UnsupportedError(
          'TokFlow n’est pas configuré pour cette plateforme.',
        );
    }
  }
}
