# TokFlow — V1 Flutter

TokFlow est une première version d'une application de vidéos courtes :
- connexion / inscription par e-mail + mot de passe ;
- fil vertical plein écran ;
- lecture automatique des vidéos ;
- pause/reprise par toucher ;
- likes persistants avec Firestore ;
- profil utilisateur et déconnexion ;
- mode démo si Firebase n'est pas encore configuré.

## Prérequis

- Flutter récent compatible avec Dart 3.11+
- Android Studio ou VS Code
- un projet Firebase

Le plugin `video_player` actuel utilisé par ce projet est compatible Android/iOS/Web. La version 2.14.1 demande Dart 3.11+. 

## 1. Créer les fichiers Flutter natifs

Si le dossier ne contient pas encore `android/`, `ios/`, etc., depuis la racine :

```bash
flutter create .
```

## 2. Installer les dépendances

```bash
flutter pub get
```

## 3. Connecter Firebase

Installe la CLI Firebase si nécessaire, puis connecte-toi :

```bash
firebase login
```

Installe FlutterFire :

```bash
dart pub global activate flutterfire_cli
```

Puis, depuis la racine du projet :

```bash
flutterfire configure
```

Choisis ton projet Firebase et les plateformes voulues. Cette commande génère le vrai `lib/firebase_options.dart`.

## 4. Activer la connexion

Dans Firebase Console :
- Authentication
- Sign-in method
- active `Email/Password`

## 5. Créer Firestore

Crée une base Cloud Firestore, puis déploie les règles :

```bash
firebase deploy --only firestore
```

## 6. Ajouter des vidéos de démonstration

Crée une collection `videos`.

Pour chaque document, ajoute par exemple :

```text
videoUrl: https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4
username: @tokflow
caption: Bienvenue sur TokFlow.
likeCount: 128
createdAt: timestamp
```

Le feed utilise automatiquement les documents `videos` triés par `createdAt`.

## 7. Lancer

```bash
flutter run
```

Pour Android :

```bash
flutter devices
flutter run -d <ID_ANDROID>
```

## Structure

```text
lib/
  main.dart
  firebase_options.dart
  models/
    video_item.dart
  screens/
    auth_gate.dart
    home_screen.dart
    login_screen.dart
    profile_screen.dart
  services/
    app_state.dart
    auth_service.dart
    video_service.dart
  theme/
    app_theme.dart
  widgets/
    video_page.dart
```

## Important

Les valeurs Firebase ne sont pas inventées dans ce projet. `flutterfire configure` doit générer la configuration propre à ton application.

Cette V1 n'est pas encore un clone complet de TikTok : commentaires, abonnements, upload vidéo, stockage des fichiers, notifications, recherche et algorithme de recommandation sont prévus pour les versions suivantes.
