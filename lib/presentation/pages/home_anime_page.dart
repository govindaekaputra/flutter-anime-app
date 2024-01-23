import 'package:anime_app/common/constant.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/presentation/pages/detail_anime_page.dart';
import 'package:anime_app/presentation/pages/season_now_anime_page.dart';
import 'package:anime_app/presentation/pages/season_upcoming_anime_page.dart';
import 'package:anime_app/presentation/pages/top_movies_anime_page.dart';
import 'package:anime_app/presentation/pages/top_series_anime_page.dart';
import 'package:anime_app/presentation/providers/anime_list_provider.dart';
import 'package:anime_app/presentation/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAnimePage extends StatefulWidget {
  const HomeAnimePage({super.key});

  @override
  State<HomeAnimePage> createState() => _HomeAnimePageState();
}

class _HomeAnimePageState extends State<HomeAnimePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<AnimeListProvider>(context, listen: false)
          ..fetchTopSeriesAnime()
          ..fetchTopMoviesAnime()
          ..fetchSeasonNowAnime()
          ..fetchSeasonUpcomingAnime());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SubHeader(
                title: 'Top series',
                onTap: () {
                  Navigator.of(context).pushNamed(TopSeriesAnimePage.routeName);
                }),
            SizedBox(
              height: 200,
              child: Consumer<AnimeListProvider>(
                builder: (context, value, child) {
                  final state = value.topSeriesAnimeState;
                  switch (state) {
                    case RequestState.empty:
                      return const Text('no data');
                    case RequestState.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case RequestState.loaded:
                      // render list
                      return _AnimeList(animeList: value.topSeriesAnime);
                    case RequestState.error:
                      return Text(value.message);
                  }
                },
              ),
            ),
            _SubHeader(
                title: 'Top movies',
                onTap: () {
                  Navigator.of(context).pushNamed(TopMoviesAnimePage.routeName);
                }),
            SizedBox(
              height: 200,
              child: Consumer<AnimeListProvider>(
                builder: (context, value, child) {
                  final state = value.topMoviesAnimeState;
                  switch (state) {
                    case RequestState.empty:
                      return const Text('no data');
                    case RequestState.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case RequestState.loaded:
                      // render list
                      return _AnimeList(animeList: value.topMoviesAnime);
                    case RequestState.error:
                      return Text(value.message);
                  }
                },
              ),
            ),
            _SubHeader(
                title: 'Season now',
                onTap: () {
                  Navigator.of(context).pushNamed(SeasonNowAnimePage.routeName);
                }),
            SizedBox(
              height: 200,
              child: Consumer<AnimeListProvider>(
                builder: (context, value, child) {
                  final state = value.seasonNowAnimeState;
                  switch (state) {
                    case RequestState.empty:
                      return const Text('no data');
                    case RequestState.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case RequestState.loaded:
                      // render list
                      return _AnimeList(animeList: value.seasonNowAnime);
                    case RequestState.error:
                      return Text(value.message);
                  }
                },
              ),
            ),
            _SubHeader(
                title: 'Season upcoming',
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(SeasonUpcomingAnimePage.routeName);
                }),
            SizedBox(
              height: 200,
              child: Consumer<AnimeListProvider>(
                builder: (context, value, child) {
                  final state = value.seasonUpcomingAnimeState;
                  switch (state) {
                    case RequestState.empty:
                      return const Text('no data');
                    case RequestState.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case RequestState.loaded:
                      // render list
                      return _AnimeList(animeList: value.seasonUpcomingAnime);
                    case RequestState.error:
                      return Text(value.message);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubHeader extends StatelessWidget {
  final String title;
  final Function onTap;
  const _SubHeader({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        InkWell(
          onTap: () {
            onTap();
          },
          child: const Row(
            children: [
              Text('See more'),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnimeList extends StatelessWidget {
  final List<Anime> animeList;
  const _AnimeList({
    required this.animeList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final anime = animeList[index];
        return MyCard(
          title: anime.title,
          image: anime.images['webp']!.imageUrl,
          onTap: () {
            // go to detail
            Navigator.of(context).pushNamed(
              DetailAnimePage.routeName,
              arguments: {
                'id': anime.malId,
                'title': anime.title,
              },
            );
          },
        );
      },
      itemCount: animeList.length,
    );
  }
}
