import 'package:anime_app/presentation/pages/detail_anime_page.dart';
import 'package:anime_app/presentation/pages/main_anime_page.dart';
import 'package:anime_app/presentation/pages/season_now_anime_page.dart';
import 'package:anime_app/presentation/pages/season_upcoming_anime_page.dart';
import 'package:anime_app/presentation/pages/top_movies_anime_page.dart';
import 'package:anime_app/presentation/pages/top_series_anime_page.dart';
import 'package:anime_app/presentation/providers/anime_detail_provider.dart';
import 'package:anime_app/presentation/providers/anime_list_provider.dart';
import 'package:anime_app/presentation/providers/favorite_anime_list_provider.dart';
import 'package:anime_app/presentation/providers/genres_anime_provider.dart';
import 'package:anime_app/presentation/providers/search_anime_provider.dart';
import 'package:anime_app/presentation/providers/season_now_anime_list_provider.dart';
import 'package:anime_app/presentation/providers/season_upcoming_anime_list_provider.dart';
import 'package:anime_app/presentation/providers/top_movies_anime_list_provider.dart';
import 'package:anime_app/presentation/providers/top_series_anime_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:anime_app/injection.dart' as di;
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<AnimeListProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopSeriesAnimeListProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopMoviesAnimeListProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeasonNowAnimeListProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeasonUpcomingAnimeListProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AnimeDetailProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<FavoriteAnimeListProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<GenresAnimeProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchAnimeProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Anime App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: MainAnimePage.routeName,
        routes: {
          MainAnimePage.routeName: (context) => const MainAnimePage(),
          TopSeriesAnimePage.routeName: (context) => const TopSeriesAnimePage(),
          TopMoviesAnimePage.routeName: (context) => const TopMoviesAnimePage(),
          SeasonNowAnimePage.routeName: (context) => const SeasonNowAnimePage(),
          SeasonUpcomingAnimePage.routeName: (context) =>
              const SeasonUpcomingAnimePage(),
          DetailAnimePage.routeName: (context) {
            final arguments =
                ModalRoute.of(context)!.settings.arguments as dynamic;
            return DetailAnimePage(
              id: arguments['id'],
              title: arguments['title'],
            );
          }
        },
      ),
    );
  }
}
