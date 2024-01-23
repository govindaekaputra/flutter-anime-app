import 'dart:async';

import 'package:anime_app/common/constant.dart';
import 'package:anime_app/presentation/providers/genres_anime_provider.dart';
import 'package:anime_app/presentation/providers/search_anime_provider.dart';
import 'package:anime_app/presentation/widgets/my_anime_list_tile.dart';
import 'package:anime_app/presentation/widgets/my_badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchAnimePage extends StatefulWidget {
  const SearchAnimePage({super.key});

  @override
  State<SearchAnimePage> createState() => _SearchAnimePageState();
}

class _SearchAnimePageState extends State<SearchAnimePage> {
  final TextEditingController keywordController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final searchProvider =
        Provider.of<SearchAnimeProvider>(context, listen: false);
    searchProvider.clearPage();
    keywordController.text = searchProvider.keyword;
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (searchProvider.page != null) {
          searchProvider.fetchSearchAnime();
        }
      }
    });
    Future.microtask(() => searchProvider.fetchSearchAnime());
    Future.microtask(() =>
        Provider.of<GenresAnimeProvider>(context, listen: false).fetchGenres());
  }

  @override
  void dispose() {
    keywordController.dispose();
    scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SearchAnimeProvider>(
        builder: (context, provider, child) {
          final animes = provider.animes;
          final state = provider.requestState;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: 0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: keywordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Search here',
                        ),
                        onChanged: (value) {
                          provider.updateKeyword(value);
                          if (_debounce?.isActive ?? false) _debounce?.cancel();
                          _debounce =
                              Timer(const Duration(milliseconds: 500), () {
                            provider.clearPage();
                            provider.fetchSearchAnime();
                          });
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const _FilterAnime(),
                        );
                      },
                      icon: const Icon(Icons.filter_list),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Builder(
                  builder: (context) {
                    switch (state) {
                      case RequestState.empty:
                        return const Text('No data');
                      case RequestState.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case RequestState.loaded:
                        return ListView.builder(
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            if (index == animes.length &&
                                provider.page != null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final anime = animes[index];
                            return MyAnimeListTile(
                              id: anime.malId,
                              image: anime.images['webp']!.imageUrl,
                              title: anime.title,
                              synopsis: anime.synopsis,
                            );
                          },
                          itemCount:
                              animes.length + (provider.page != null ? 1 : 0),
                        );
                      case RequestState.error:
                        return Text(provider.message);
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FilterAnime extends StatefulWidget {
  const _FilterAnime();

  @override
  State<_FilterAnime> createState() => __FilterAnimeState();
}

class __FilterAnimeState extends State<_FilterAnime> {
  List<Widget> _sectionBuilder(
      {required String title,
      required Widget content,
      bool isUseDivider = true}) {
    return [
      Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(
        height: 8,
      ),
      content,
      if (isUseDivider) ...[
        const SizedBox(
          height: 8,
        ),
        const Divider(),
        const SizedBox(
          height: 8,
        ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Consumer<SearchAnimeProvider>(
            builder: (context, searchProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._sectionBuilder(
                    title: 'Genres',
                    content: Consumer<GenresAnimeProvider>(
                      builder: (context, genreProvider, child) {
                        final state = genreProvider.genresRequestState;
                        final genres = genreProvider.genres;
                        if (state == RequestState.loaded) {
                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(
                              genres.length,
                              (index) => MyBadge(
                                text: genres[index].name,
                                isActive: searchProvider
                                    .isIncludeInGenre(genres[index].malId),
                                onClick: () {
                                  searchProvider
                                      .updateGenre(genres[index].malId);
                                },
                              ),
                            ),
                          );
                        } else if (state == RequestState.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const Text('No data');
                        }
                      },
                    ),
                  ),
                  ..._sectionBuilder(
                    title: 'Type',
                    content: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        AnimeType.values.length,
                        (index) => MyBadge(
                          text: AnimeType.values[index].name,
                          isActive: searchProvider
                              .isActiveAnimeType(AnimeType.values[index]),
                          onClick: () {
                            searchProvider
                                .updateAnimeType(AnimeType.values[index]);
                          },
                        ),
                      ),
                    ),
                  ),
                  ..._sectionBuilder(
                    title: 'Status',
                    content: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        AnimeStatus.values.length,
                        (index) => MyBadge(
                          text: AnimeStatus.values[index].name,
                          isActive: searchProvider
                              .isActiveAnimeStatus(AnimeStatus.values[index]),
                          onClick: () {
                            searchProvider
                                .updateAnimeStatus(AnimeStatus.values[index]);
                          },
                        ),
                      ),
                    ),
                  ),
                  ..._sectionBuilder(
                    title: 'Rating',
                    isUseDivider: false,
                    content: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        AnimeRating.values.length,
                        (index) => MyBadge(
                          text: AnimeRating.values[index].description,
                          isActive: searchProvider
                              .isActiveAnimeRating(AnimeRating.values[index]),
                          onClick: () {
                            searchProvider
                                .updateAnimeRating(AnimeRating.values[index]);
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        searchProvider.clearPage();
                        searchProvider.fetchSearchAnime();
                      },
                      child: const Text('Search'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
