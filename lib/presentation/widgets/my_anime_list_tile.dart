import 'package:anime_app/presentation/pages/detail_anime_page.dart';
import 'package:flutter/material.dart';

class MyAnimeListTile extends StatelessWidget {
  final int id;
  final String image;
  final String title;
  final String? synopsis;
  const MyAnimeListTile({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.synopsis,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        image,
        fit: BoxFit.cover,
        width: 50,
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        synopsis ?? 'Synopsis unknown',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          DetailAnimePage.routeName,
          arguments: {
            'id': id,
            'title': title,
          },
        );
      },
    );
  }
}
