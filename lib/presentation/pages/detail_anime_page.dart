import 'package:anime_app/common/constant.dart';
import 'package:anime_app/domain/entities/favorite_anime.dart';
import 'package:anime_app/presentation/providers/anime_detail_provider.dart';
import 'package:anime_app/presentation/providers/favorite_anime_list_provider.dart';
import 'package:anime_app/presentation/widgets/my_badge.dart';
import 'package:anime_app/presentation/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailAnimePage extends StatefulWidget {
  static const routeName = '/detail/anime';
  final int id;
  final String title;
  const DetailAnimePage({super.key, required this.id, required this.title});

  @override
  State<DetailAnimePage> createState() => _DetailAnimePageState();
}

class _DetailAnimePageState extends State<DetailAnimePage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AnimeDetailProvider>(context, listen: false);
    Future.microtask(
      () => provider
        ..loadFavoriteAnimeStatus(id: widget.id)
        ..fetchAnimeById(id: widget.id)
        ..fetchAnimeCharactersByAnimeId(id: widget.id)
        ..fetchAnimeRecommendationsByAnimeId(id: widget.id),
    );
  }

  void _toggleFavorite() {
    final provider = Provider.of<AnimeDetailProvider>(context, listen: false);
    final favoriteListProvider =
        Provider.of<FavoriteAnimeListProvider>(context, listen: false);
    if (provider.animeState != RequestState.loaded) return;
    final anime = provider.anime;
    if (provider.isAddedToFavorite) {
      provider.removeFromFavoriteAnime(id: anime.malId);
    } else {
      provider.addToFavoriteAnime(
        favoriteAnime: FavoriteAnime(
          malId: anime.malId,
          imageUrl: anime.images['webp']!.imageUrl,
          title: anime.title,
          type: anime.type,
          synopsis: anime.synopsis,
        ),
      );
    }
    favoriteListProvider.clearPage();
    favoriteListProvider.loadFavoritesAnime();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimeDetailProvider>(
      builder: (context, value, child) {
        final isFavorite = value.isAddedToFavorite;
        final animeState = value.animeState;
        final characterState = value.charactersState;
        final recommendationState = value.recommendationsState;
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: [
              IconButton(
                  onPressed: () {
                    _toggleFavorite();
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                  )),
            ],
          ),
          body: Builder(
            builder: (context) {
              switch (animeState) {
                case RequestState.empty:
                  return const Center(
                    child: Text('No data'),
                  );
                case RequestState.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case RequestState.loaded:
                  final anime = value.anime;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                anime.images['webp']!.largeImageUrl,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                anime.title,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                anime.synopsis ?? 'Synopsis unknown',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 16),
                              const Divider(),
                              Text(
                                'Genres :',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: List.generate(
                                  anime.genres.length,
                                  (index) => MyBadge(
                                    text: anime.genres[index].name,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Divider(),
                              Text(
                                'Aired :',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(anime.aired.string),
                              const SizedBox(height: 16),
                              const Divider(),
                              Text(
                                'Characters :',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              SizedBox(
                                height: 180,
                                child: Builder(
                                  builder: (context) {
                                    return switch (characterState) {
                                      RequestState.empty =>
                                        const Text('No characters'),
                                      RequestState.loading => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      RequestState.loaded => ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) =>
                                              MyCard(
                                            title: value.characters[index]
                                                .character.name,
                                            image: value.characters[index]
                                                .character.images.webp.imageUrl,
                                            onTap: () {},
                                          ),
                                          itemCount: value.characters.length,
                                        ),
                                      RequestState.error => Text(value.message),
                                    };
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Divider(),
                              Text(
                                'Recommendations :',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              SizedBox(
                                height: 180,
                                child: Builder(
                                  builder: (context) {
                                    return switch (recommendationState) {
                                      RequestState.empty =>
                                        const Text('No recommendations'),
                                      RequestState.loading => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      RequestState.loaded => ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) =>
                                              MyCard(
                                            title: value.recommendations[index]
                                                .entry.title,
                                            image: value.recommendations[index]
                                                .entry.images['webp']!.imageUrl,
                                            onTap: () {},
                                          ),
                                          itemCount:
                                              value.recommendations.length,
                                        ),
                                      RequestState.error => Text(value.message),
                                    };
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                case RequestState.error:
                  return Center(
                    child: Text(value.message),
                  );
              }
            },
          ),
        );
      },
    );
  }
}
