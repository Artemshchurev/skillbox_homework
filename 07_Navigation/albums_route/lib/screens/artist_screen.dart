import 'package:albums_route/artists_repo.dart';
import 'package:flutter/material.dart';

class ArtistScreen extends StatelessWidget {
  static String routeName = '/artist';
  final String link;
  ArtistScreen({@required this.link});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Artist'),
          ),
          body: FutureBuilder(
            future: ArtistsRepo.fetchAboutArtist(link),
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (projectSnap.hasData) {
                return SingleChildScrollView(child: Text(projectSnap.data));
              }
              return Text('no data');
            },
          )
        )
    );
  }
}
