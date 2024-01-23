import 'package:anime_app/common/constant.dart';
import 'package:anime_app/presentation/providers/season_upcoming_anime_list_provider.dart';
import 'package:anime_app/presentation/widgets/my_anime_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeasonUpcomingAnimePage extends StatefulWidget {
  static const routeName = '/season-upcoming';
  const SeasonUpcomingAnimePage({super.key});

  @override
  State<SeasonUpcomingAnimePage> createState() =>
      _SeasonUpcomingAnimePageState();
}

class _SeasonUpcomingAnimePageState extends State<SeasonUpcomingAnimePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<SeasonUpcomingAnimeListProvider>();
    provider.clearPage();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (provider.page != null) {
          provider.fetchSeasonUpcomingAnime();
        }
      }
    });
    Future.microtask(() => provider.fetchSeasonUpcomingAnime());
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
        title: const Text('Season upcoming'),
      ),
      body: Consumer<SeasonUpcomingAnimeListProvider>(
        builder: (context, value, child) {
          final state = value.seasonUpcomingAnimeState;
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
                  if (index == value.seasonUpcomingAnime.length &&
                      value.page != null) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final anime = value.seasonUpcomingAnime[index];
                  return MyAnimeListTile(
                    id: anime.malId,
                    image: anime.images['webp']!.imageUrl,
                    title: anime.title,
                    synopsis: anime.synopsis,
                  );
                },
                itemCount: value.seasonUpcomingAnime.length +
                    (value.page != null ? 1 : 0),
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
