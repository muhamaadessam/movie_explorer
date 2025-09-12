import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/services/services_locator.dart';
import 'package:movie_explorer/core/utils/app_string.dart';
import 'package:movie_explorer/movies/presentation/screens/movies_screen.dart';

import 'core/network/Local/cache_helper.dart';
import 'core/network/Remote/dio_helper.dart';
import 'movies/presentation/controller/favorites/favorites_cubit.dart';
import 'movies/presentation/controller/search/search_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  await DioHelper.init();
  await CacheHelper.init();
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
      ],
      child: MaterialApp(
        title: AppString.appName,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.grey.shade900,
        ),
        home: const MoviesScreen(),
      ),
    );
  }
}
