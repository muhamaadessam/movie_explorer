# Movie Explorer

A Flutter application for discovering and exploring movies with a clean and intuitive user interface.

## 📱 Features

- **Movie Discovery**: Browse popular, top-rated, and upcoming movies
- **Search Functionality**: Find movies by title with real-time search
- **Movie Details**: View comprehensive information about movies including cast, crew, ratings, and synopsis
- **Responsive Design**: Optimized for both Android and iOS devices
- **Offline Support**: Cache movie data for offline viewing
- **Dark/Light Theme**: Support for both light and dark mode themes

## 🏗️ Architecture

This project follows **Clean Architecture** principles combined with **BLoC (Business Logic Component)** pattern for state management, ensuring separation of concerns and maintainability.

### Architecture Layers

```
┌───────────────────────────────────────┐
│             Presentation Layer        │
│  ┌───────────────┐ ┌─────────────────┐│
│  │     Screens   │ │     Widgets     ││
│  └───────────────┘ └─────────────────┘│
│  ┌───────────────┐ ┌─────────────────┐│
│  │      BLoC     │ │     Events      ││
│  │     States    │ │    & States     ││
│  └───────────────┘ └─────────────────┘│
└───────────────────────────────────────┘
┌───────────────────────────────────────┐
│              Domain Layer             │
│  ┌───────────────┐ ┌─────────────────┐│
│  │    Entities   │ │  Use Cases      ││
│  └───────────────┘ └─────────────────┘│
│  ┌───────────────────────────────────┐│
│  │           Repositories            ││
│  │          (Interfaces)             ││
│  └───────────────────────────────────┘│
└───────────────────────────────────────┘
┌───────────────────────────────────────┐
│               Data Layer              │
│  ┌───────────────┐ ┌─────────────────┐│
│  │     Models    │ │  Data Sources   ││
│  └───────────────┘ └─────────────────┘│
│  ┌───────────────┐ ┌─────────────────┐│
│  │  Repository   │ │     Network     ││
│  │Implementations│ │     Cache       ││
│  └───────────────┘ └─────────────────┘│
└───────────────────────────────────────┘
```

### Core Components

#### 1. **Presentation Layer**
- **Screens**: UI pages that users interact with
- **Widgets**: Reusable UI components
- **BLoC**: Manages application state and business logic
- **Events & States**: Handle user interactions and UI updates

#### 2. **Domain Layer**
- **Entities**: Core business objects (Movie, Cast, Genre)
- **Use Cases**: Business logic operations (GetMovies, SearchMovies, GetMovieDetails)
- **Repository Interfaces**: Contracts for data operations

#### 3. **Data Layer**
- **Models**: Data transfer objects with JSON serialization
- **Repository Implementations**: Concrete implementations of domain repositories
- **Data Sources**: Remote (API) and Local (Cache) data sources
- **Network Layer**: HTTP client configuration and API endpoints

## 🛠️ Technology Stack

- **Framework**: Flutter 3.x
- **State Management**: BLoC Pattern with flutter_bloc
- **Dependency Injection**: get_it
- **Network**: dio for HTTP requests
- **Local Storage**: hive for caching
- **Architecture**: Clean Architecture
- **API**: The Movie Database (TMDb) API
- **Image Loading**: cached_network_image
- **Routing**: go_router or flutter navigation

## 📂 Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── error/
│   ├── network/
│   ├── params/
│   └── utils/
├── features/
│   ├── movies/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   └── search/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── injection_container.dart
└── main.dart
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=2.17.0)
- Android Studio / VS Code
- TMDb API Key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/muhamaadessam/movie_explorer.git
   cd movie_explorer
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Key**
    - Create an account at [The Movie Database](https://www.themoviedb.org/)
    - Generate an API key
    - Create a `.env` file in the root directory
   ```env
   TMDB_API_KEY=your_api_key_here
   TMDB_BASE_URL=https://api.themoviedb.org/3
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📋 API Integration

The app integrates with The Movie Database (TMDb) API to fetch:

- **Popular Movies**: `/movie/popular`
- **Top Rated Movies**: `/movie/top_rated`
- **Upcoming Movies**: `/movie/upcoming`
- **Movie Details**: `/movie/{movie_id}`
- **Movie Search**: `/search/movie`
- **Movie Credits**: `/movie/{movie_id}/credits`

### Example API Response Handling

```dart
class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.backdropPath,
    required super.voteAverage,
    required super.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: json['release_date'] ?? '',
    );
  }
}
```

## 🔧 Additional Improvements Made

### 1. **Performance Optimizations**
- **Image Caching**: Implemented cached network images for smooth scrolling
- **Lazy Loading**: Pagination for movie lists to reduce initial load time
- **Memory Management**: Proper disposal of controllers and streams

### 2. **User Experience Enhancements**
- **Pull-to-Refresh**: Refresh movie data with pull gesture
- **Loading States**: Skeleton screens and shimmer effects during data loading
- **Error Handling**: User-friendly error messages and retry mechanisms
- **Search Debouncing**: Optimized search with delayed API calls

### 3. **Code Quality & Maintainability**
- **Clean Code**: Following SOLID principles and clean code practices
- **Type Safety**: Comprehensive use of Dart's type system
- **Error Handling**: Robust error handling with custom exceptions
- **Testing**: Unit tests for use cases and widget tests for UI components

### 4. **Accessibility Features**
- **Semantic Labels**: Proper accessibility labels for screen readers
- **Keyboard Navigation**: Full keyboard navigation support
- **High Contrast**: Support for high contrast mode
- **Text Scaling**: Responsive text that scales with system settings

### 5. **Security & Privacy**
- **API Key Security**: Environment variables for sensitive data
- **Data Validation**: Input validation and sanitization
- **Network Security**: Certificate pinning for API calls

## 🧪 Testing

Run tests using the following commands:

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test

# Coverage report
flutter test --coverage
```

## 📱 Screenshots

| Home Screen | Movie Details | Search Results |
|-------------|---------------|----------------|
| ![Home](screenshots/home.png) | ![Details](screenshots/details.png) | ![Search](screenshots/search.png) |

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [The Movie Database (TMDb)](https://www.themoviedb.org/) for providing the movie data API
- [Flutter](https://flutter.dev/) team for the amazing framework
- The Flutter community for continuous support and contributions

## 📞 Contact

Muhammad Essam - [GitHub](https://github.com/muhamaadessam)

Project Link: [https://github.com/muhamaadessam/movie_explorer](https://github.com/muhamaadessam/movie_explorer)