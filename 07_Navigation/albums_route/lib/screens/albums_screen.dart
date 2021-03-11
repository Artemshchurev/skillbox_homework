import 'package:albums_route/artists_repo.dart';
import 'package:albums_route/screens/artist_screen.dart';
import 'package:albums_route/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AlbumsScreen extends StatelessWidget {
  static String routeName = '/albums';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    },
                    child: ListTile(
                      title: Text('Home'),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Albums',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  )
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Albums'),
          ),
          body: FutureBuilder(
            future: ArtistsRepo.fetchArtists(),
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(),
                );
              } else if (projectSnap.hasData) {
                return ListView.builder(
                  itemCount: projectSnap.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: GestureDetector(
                        child: Text(projectSnap.data[index]['name']),
                        onTap: () => Navigator.of(context).pushNamed('${ArtistScreen.routeName}/${projectSnap.data[index]['link']}'),
                      ),
                    );
                  },
                );
              }
              return Text('no data');
            },
          )
      ),
    );
  }
}
