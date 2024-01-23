import 'package:anime_app/common/constant.dart';
import 'package:anime_app/presentation/providers/favorite_anime_list_provider.dart';
import 'package:anime_app/presentation/widgets/my_anime_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteAnimePage extends StatefulWidget {
  const FavoriteAnimePage({super.key});

  @override
  State<FavoriteAnimePage> createState() => _FavoriteAnimePageState();
}

class _FavoriteAnimePageState extends State<FavoriteAnimePage> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    final provider = context.read<FavoriteAnimeListProvider>();
    provider.clearPage();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (provider.page != null) {
          provider.loadFavoritesAnime();
        }
      }
    });
    Future.microtask(() => provider.loadFavoritesAnime());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteAnimeListProvider>(
      builder: (context, value, child) {
        final state = value.favoritesAnimeState;
        switch (state) {
          case RequestState.empty:
            return const Center(child: Text('no data'));
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RequestState.loaded:
            return ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) {
                if (index == value.favoritesAnime.length &&
                    value.page != null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final anime = value.favoritesAnime[index];
                return MyAnimeListTile(
                  id: anime.malId,
                  image: anime.imageUrl,
                  title: anime.title,
                  synopsis: anime.synopsis,
                );
              },
              itemCount:
                  value.favoritesAnime.length + (value.page != null ? 1 : 0),
            );
          case RequestState.error:
            return Center(child: Text(value.message));
        }
      },
    );
  }
}
