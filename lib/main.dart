import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_explorer/core/extensions/context_extension.dart';
import 'package:movie_explorer/core/services/services_locator.dart';
import 'package:movie_explorer/movies/presentation/screens/movies_screen.dart';

import 'core/network/Local/cache_helper.dart';
import 'core/network/Remote/dio_helper.dart';
import 'core/themes/theme_cubit/app_theme_cubit.dart';
import 'movies/presentation/controller/favorites/favorites_cubit.dart';
import 'movies/presentation/controller/search/search_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  await DioHelper.init();
  await CacheHelper.init();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<FavoritesCubit>()..loadFavorites(),
        ),
        BlocProvider(create: (context) => sl<SearchCubit>()),
        BlocProvider(create: (context) => AppThemeCubit()),
      ],
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Movie Explorer',
            theme: state.themeData,
            themeMode: context.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const MoviesScreen(),
          );
        },
      ),
    );
  }
}
