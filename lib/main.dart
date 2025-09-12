import 'package:flutter/material.dart';
import 'package:movie_explorer/core/services/services_locator.dart';
import 'package:movie_explorer/core/utils/app_string.dart';
import 'package:movie_explorer/movies/presentation/screens/movies_screen.dart';

import 'core/network/Local/cache_helper.dart';
import 'core/network/Remote/dio_helper.dart';

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
    return MaterialApp(
      title: AppString.appName,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade900,
      ),
      home: const MoviesScreen(),
    );
  }
}
