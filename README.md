# MID-Project MAD

A Flutter application for a digital visiting card with animation, profile picture, QR code and save contact functionality.

## 🚀 Features
- Beautiful flip animation between front and back of the card  
- Front: User name, job title, profile photo  
- Back: Phone number, email, website, QR code  
- “Save Contact” button (shows SnackBar)  
- Responsive layout: works on different screen sizes

## 🧑‍💻 Built With
- [Flutter](https://flutter.dev)  
- Dart  
- Package: `qr_flutter` (for QR code generation)  

## 📦 Getting Started

### Prerequisites
- Flutter SDK installed  
- A connected device or emulator to run the app  
- Internet access to fetch packages

### Installation
```bash
# Clone the repository
git clone https://github.com/BasitAli9/MID-Project-MAD.git

# Navigate into the project directory
cd MID-Project-MAD

# Get the dependencies
flutter pub get

# Run the app
flutter run
```

### Adding Your Profile Picture
1. Place your image in the `assets/` folder (e.g., `assets/profile.jpg`)  
2. Update the `imagePath` field in `User` class in `main.dart`  
3. Update `pubspec.yaml` to include:
```yaml
flutter:
  assets:
    - assets/profile.jpg
```
4. Run `flutter pub get` again if needed.

## 📂 Project Structure
```
MID-Project-MAD/
├─ android/
├─ ios/
├─ lib/
│  └─ main.dart
├─ assets/
│  └─ profile.jpg
├─ pubspec.yaml
└─ README.md
```

## 🤝 Branching Strategy
- Use `main` branch (or `master`) for stable/app-ready code  
- Create feature branches (e.g., `dev`, `feature-animation`) for ongoing work  
```bash
git checkout -b dev
git push -u origin dev
```

## 🧪 Usage
- Launch the app  
- Tap on the card to flip between front and back  
- On the back side: view contact info, QR code, and tap “Save Contact”


*Created by Basit Ali — Happy coding!*
