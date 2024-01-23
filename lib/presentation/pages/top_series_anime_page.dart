import 'package:anime_app/common/constant.dart';
import 'package:anime_app/presentation/providers/top_series_anime_list_provider.dart';
import 'package:anime_app/presentation/widgets/my_anime_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopSeriesAnimePage extends StatefulWidget {
  static const routeName = '/top-series';
  const TopSeriesAnimePage({super.key});

  @override
  State<TopSeriesAnimePage> createState() => _TopSeriesAnimePageState();
}

class _TopSeriesAnimePageState extends State<TopSeriesAnimePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<TopSeriesAnimeListProvider>();
    provider.clearPage();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (provider.page != null) {
          provider.fetchTopSeriesAnime();
        }
      }
    });

    Future.microtask(() => provider.fetchTopSeriesAnime());
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
        title: const Text('Top series'),
      ),
      body: Consumer<TopSeriesAnimeListProvider>(
        builder: (context, value, child) {
          final state = value.topSeriesAnimeState;
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
                  if (index == value.topSeriesAnime.length &&
                      value.page != null) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final anime = value.topSeriesAnime[index];
                  return MyAnimeListTile(
                    id: anime.malId,
                    image: anime.images['webp']!.imageUrl,
                    title: anime.title,
                    synopsis: anime.synopsis,
                  );
                },
                itemCount:
                    value.topSeriesAnime.length + (value.page != null ? 1 : 0),
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
