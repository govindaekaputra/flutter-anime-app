import 'package:anime_app/common/constant.dart';
import 'package:anime_app/presentation/providers/top_movies_anime_list_provider.dart';
import 'package:anime_app/presentation/widgets/my_anime_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopMoviesAnimePage extends StatefulWidget {
  static const routeName = '/top-movies';
  const TopMoviesAnimePage({super.key});

  @override
  State<TopMoviesAnimePage> createState() => _TopMoviesAnimePageState();
}

class _TopMoviesAnimePageState extends State<TopMoviesAnimePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<TopMoviesAnimeListProvider>();
    provider.clearPage();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (provider.page != null) {
          provider.fetchTopMoviesAnime();
        }
      }
    });
    Future.microtask(() => provider.fetchTopMoviesAnime());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top movies'),
      ),
      body: Consumer<TopMoviesAnimeListProvider>(
        builder: (context, value, child) {
          final state = value.topMoviesAnimeState;
          switch (state) {
            case RequestState.empty:
              return const Center(
                child: Text('No data'),
              );
            case RequestState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RequestState.loaded:
              return ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index == value.topMoviesAnime.length &&
                      value.page != null) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final anime = value.topMoviesAnime[index];
                  return MyAnimeListTile(
                    id: anime.malId,
                    image: anime.images['webp']!.imageUrl,
                    title: anime.title,
                    synopsis: anime.synopsis,
                  );
                },
                itemCount:
                    value.topMoviesAnime.length + (value.page != null ? 1 : 0),
              );
            case RequestState.error:
              return Center(
                child: Text(value.message),
              );
          }
        },
      ),
    );
  }
}
