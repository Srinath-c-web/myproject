# Firebase setup

1. Create a Firebase project named `eventra` (or any name you prefer).
2. Enable Authentication → Email/Password and Google.
3. Create a Firestore database.
4. Enable Storage.
5. Add an Android app with your package name.
6. Install FlutterFire CLI:
   `dart pub global activate flutterfire_cli`
7. Run from this project:
   `flutterfire configure`
8. Import Firebase initialization in `main.dart` and set `AppConfig.useFirebase = true`.
9. Deploy:
   `firebase deploy --only firestore:rules,storage,functions`

The included demo backend is intentionally local-only until Firebase credentials are configured.
Never put a Firebase service-account JSON file into a public Git repository.
