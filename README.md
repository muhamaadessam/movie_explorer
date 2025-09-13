# 🎬 Movie Explorer

A modern Flutter application for discovering and exploring movies using The Movie Database (TMDB) API. Built with clean architecture principles and state management using BLoC pattern.

## ✨ Features

- **🎭 Popular Movies**: Browse trending and popular movies with pagination
- **🔍 Search**: Search for movies by title with real-time results
- **❤️ Favorites**: Save your favorite movies locally for quick access
- **📱 Movie Details**: View detailed information about each movie including:
   - Movie poster and backdrop images
   - Overview and synopsis
   - Release date and rating
   - Cast and crew information
- **🌙 Dark/Light Theme**: Toggle between dark and light themes
- **📱 Responsive Design**: Optimized for both mobile and tablet devices
- **🔄 Offline Support**: Cached images and local favorites storage

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Core functionality
│   ├── components/         # Reusable UI components
│   ├── error/             # Error handling
│   ├── extensions/        # Dart extensions
│   ├── network/           # Network layer
│   ├── services/          # Dependency injection
│   ├── themes/            # App theming
│   ├── usecase/           # Base use case
│   └── utils/             # Utilities
├── features/              # Feature modules
│   ├── movies/           # Movies feature
│   │   ├── data/         # Data layer
│   │   ├── domain/       # Domain layer
│   │   └── presentation/ # Presentation layer
│   ├── favorites/        # Favorites feature
│   └── search/           # Search feature
└── main.dart             # App entry point
```

### 🎯 Key Architectural Patterns

- **Clean Architecture**: Separation of data, domain, and presentation layers
- **BLoC Pattern**: State management using `flutter_bloc`
- **Repository Pattern**: Data abstraction layer
- **Dependency Injection**: Using `get_it` for service locator
- **Use Cases**: Business logic encapsulation

## 🛠️ Tech Stack

- **Framework**: Flutter 3.7.2+
- **State Management**: BLoC (flutter_bloc)
- **HTTP Client**: Dio
- **Dependency Injection**: Get It
- **Local Storage**: SharedPreferences
- **Image Caching**: cached_network_image
- **Animations**: animate_do
- **UI Components**: Material Design
- **Fonts**: Google Fonts
- **Loading States**: Shimmer effects

## 📦 Dependencies

### Core Dependencies
- `flutter_bloc: ^9.1.1` - State management
- `dio: ^5.9.0` - HTTP client
- `get_it: ^8.2.0` - Dependency injection
- `equatable: ^2.0.3` - Value equality
- `dartz: ^0.10.1` - Functional programming

### UI & UX
- `animate_do: ^4.2.0` - Animations
- `cached_network_image: ^3.2.1` - Image caching
- `carousel_slider: ^5.1.1` - Image carousels
- `google_fonts: ^6.3.1` - Typography
- `shimmer: ^3.0.0` - Loading effects

### Storage & Network
- `shared_preferences: ^2.5.3` - Local storage
- `internet_connection_checker: ^1.0.0+1` - Connectivity
- `connectivity_plus: ^6.0.3` - Network status

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/movie_explorer.git
   cd movie_explorer
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate app icons and splash screen**
   ```bash
   flutter pub run flutter_launcher_icons:main
   flutter pub run flutter_native_splash:create
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### 🔑 API Configuration

The app uses The Movie Database (TMDB) API. The API key is already configured in the project, but for production use, consider:

1. Moving the API key to environment variables
2. Using a backend proxy to hide the API key
3. Implementing proper API key rotation

## 📱 Screenshots

*Add screenshots of your app here*

## 🎨 UI/UX Features

- **Material Design 3**: Modern Material Design components
- **Responsive Layout**: Adapts to different screen sizes
- **Smooth Animations**: Engaging user interactions
- **Loading States**: Shimmer effects for better UX
- **Error Handling**: User-friendly error messages
- **Theme Support**: Dark and light mode toggle

## 🔧 Development

### Project Structure

Each feature follows the same structure:
- `data/` - Data sources, models, and repositories
- `domain/` - Entities, repositories interfaces, and use cases
- `presentation/` - UI components, screens, and BLoC

### Code Style

- Follows Flutter/Dart conventions
- Uses `flutter_lints` for code quality
- Implements proper error handling
- Includes comprehensive comments

### Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/
```

## 🚀 Build & Deploy

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [The Movie Database (TMDB)](https://www.themoviedb.org/) for providing the movie data API
- Flutter team for the amazing framework
- All the open-source package contributors

## 📞 Contact

Project Link: [https://github.com/muhamaadessam/movie_explorer](https://github.com/muhamaadessam/movie_explorer)

---

⭐ Star this repository if you found it helpful!
