# Eventra — College Event Discovery & Registration App

A production-oriented Flutter + Firebase starter built from the supplied Eventra mobile UI reference.

## Included

- Splash and onboarding flow
- Email/password login UI and demo authentication mode
- Interest selection
- Personalized home page
- Explore/search/filter events
- Event details
- Event registration
- Registration success
- My Events
- Notifications
- Profile and bookmarks
- Organizer create-event flow
- Admin dashboard with approval actions
- QR registration ticket screen
- Firebase service layer ready for Authentication, Firestore, Storage and FCM
- Firestore and Storage security rules
- Cloud Functions starter for reminders/notifications
- Design reference image in `assets/design_reference.jpg`

## Important: demo mode vs Firebase

The app is configured to run in **Demo Mode** by default so it can be opened and edited immediately without exposing any Firebase secrets.

1. Install Flutter 3.24+ (or current stable).
2. From the project root run:
   ```bash
   flutter pub get
   flutter run
   ```
3. When you are ready for real backend services, create a Firebase project and run:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
4. Set `useFirebase = true` in `lib/app_config.dart`.
5. Deploy rules/functions:
   ```bash
   firebase deploy --only firestore:rules,storage,functions
   ```

No API keys or service-account secrets are included in this ZIP.

## Antigravity / AI IDE workflow

Open the extracted folder as the workspace. The most useful starting files are:

- `lib/main.dart` — application entry point and navigation
- `lib/screens/eventra_screens.dart` — screen implementations
- `lib/models/event.dart` — event model and demo data
- `lib/services/eventra_backend.dart` — Firebase/backend integration layer
- `lib/app_config.dart` — demo/Firebase switch
- `firestore.rules` — database authorization rules
- `storage.rules` — image/file authorization rules
- `functions/index.js` — Cloud Functions starter

Ask your coding agent to make changes in small commits and keep the existing Firebase security rules intact.

## Suggested Firebase collections

`users/{uid}`
`events/{eventId}`
`registrations/{registrationId}`
`notifications/{notificationId}`
`bookmarks/{bookmarkId}`

Each event contains `organizerId`, `status`, `category`, `date`, `registrationDeadline`, `imageUrl`, and `registrationCount`.

## Production checklist

- Add Firebase App Check
- Configure Android/iOS Firebase files
- Enable Google sign-in in Firebase Authentication
- Add real FCM server configuration
- Replace demo data with Firestore streams
- Add App Store / Play Store signing
- Add privacy policy and terms
- Test security rules with the Firebase Emulator Suite
- Add crash reporting and analytics
