import 'package:anime_app/common/constant.dart';
import 'package:anime_app/presentation/providers/season_now_anime_list_provider.dart';
import 'package:anime_app/presentation/widgets/my_anime_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeasonNowAnimePage extends StatefulWidget {
  static const routeName = '/season-now';
  const SeasonNowAnimePage({super.key});

  @override
  State<SeasonNowAnimePage> createState() => _SeasonNowAnimePageState();
}

class _SeasonNowAnimePageState extends State<SeasonNowAnimePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<SeasonNowAnimeListProvider>();
    provider.clearPage();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (provider.page != null) {
          provider.fetchSeasonNowAnime();
        }
      }
    });
    Future.microtask(() => provider.fetchSeasonNowAnime());
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
        title: const Text('Season now'),
      ),
      body: Consumer<SeasonNowAnimeListProvider>(
        builder: (context, value, child) {
          final state = value.seasonNowAnimeState;
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
                  if (index == value.seasonNowAnime.length &&
                      value.page != null) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final anime = value.seasonNowAnime[index];
                  return MyAnimeListTile(
                    id: anime.malId,
                    image: anime.images['webp']!.imageUrl,
                    title: anime.title,
                    synopsis: anime.synopsis,
                  );
                },
                itemCount:
                    value.seasonNowAnime.length + (value.page != null ? 1 : 0),
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
