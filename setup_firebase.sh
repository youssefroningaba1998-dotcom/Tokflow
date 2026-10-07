#!/usr/bin/env bash
set -e

echo "Installation des dépendances..."
flutter pub get

echo "Configuration FlutterFire..."
dart pub global activate flutterfire_cli
flutterfire configure

echo ""
echo "Configuration terminée."
echo "Active maintenant Email/Password dans Firebase Authentication,"
echo "crée Firestore, puis lance: flutter run"
