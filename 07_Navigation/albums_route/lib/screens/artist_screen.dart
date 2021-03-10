import 'package:albums_route/artists_repo.dart';
import 'package:flutter/material.dart';

class ArtistScreen extends StatefulWidget {
  static String routeName = '/artist';
  final String link;
  ArtistScreen({@required this.link});

  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {


  @override
  Widget build(BuildContext context) {

    // ArtistsRepo.fetchArtists().then((value) => )

    return SafeArea(
      child: Scaffold(
        body: Text('Artist'),
      )
    );
  }
}
