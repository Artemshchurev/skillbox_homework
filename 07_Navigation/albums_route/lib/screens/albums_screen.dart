import 'package:albums_route/artists_repo.dart';
import 'package:flutter/material.dart';

class AlbumsScreen extends StatelessWidget {
  static String routeName = '/albums';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Albums'),
          ),
          body: FutureBuilder(
            future: ArtistsRepo.fetchArtists(),
            builder: (context, projectSnap) {
              print(projectSnap.connectionState);
              if (projectSnap.connectionState == ConnectionState.waiting) {
                print('loading');
                return Text('loading');
              }
              print(projectSnap.data);

              if (projectSnap.hasData) {
                return ListView.builder(
                  itemCount: projectSnap.data.length,
                  itemBuilder: (context, index) {
                    print(projectSnap.data[index]);
                    return Column(
                      children: <Widget>[
                        Text('has some data')
                        // Widget to display the list of project
                      ],
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
