import 'package:anime_app/presentation/pages/home_anime_page.dart';
import 'package:anime_app/presentation/pages/search_anime_page.dart';
import 'package:flutter/material.dart';
import 'package:anime_app/presentation/pages/favorite_anime_page.dart';

class MainAnimePage extends StatefulWidget {
  static const routeName = '/';
  const MainAnimePage({super.key});

  @override
  State<MainAnimePage> createState() => _MainAnimePageState();
}

class _MainAnimePageState extends State<MainAnimePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const <Widget>[
          Text('Home'),
          Text('Favorite'),
          Text('Search'),
        ][currentPageIndex],
      ),
      body: const <Widget>[
        HomeAnimePage(),
        FavoriteAnimePage(),
        SearchAnimePage(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_outline),
            label: 'Favorite',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
