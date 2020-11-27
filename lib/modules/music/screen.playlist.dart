import 'package:flutter/material.dart';
import 'package:utm_vinculacion/routes/route.names.dart';

import 'package:utm_vinculacion/widgets/components/header.dart' as component;

import 'helper.image.dart';
import 'model.playlist.dart';
import 'provider.music.dart';

class PlaylistScreen extends StatelessWidget {

  final _musicProvider = new MusicProvider();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    _musicProvider.queryPlaylist();

    return Scaffold(
      body: Column(
        children: [
          component.getHeader(context, size, "MÚSICA"),
          _getPlaylist(context)
        ],
      )
    );
  }

  Widget _getPlaylist(BuildContext context) {

    return StreamBuilder(
      stream: this._musicProvider.playlistStream,
      builder: (BuildContext context, AsyncSnapshot<List<PlayList>> snapshot){
        
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(snapshot.data.isEmpty) {
          return ListTile(
            leading: Icon(Icons.sentiment_dissatisfied),
            title: Text("Sin contenido")
          );
        }

        return Column(
          children: snapshot.data.map((PlayList playlist){
            return _getPlayListTile(context, playlist);
          }).toList(),
        );

      },
    );

  }

  Widget _getPlayListTile(BuildContext context, PlayList playlist) {
    return ListTile(
      leading: getImage(playlist.image),
      title: Text(playlist.title ?? "Sin título"),
      subtitle: Text((playlist.description.isEmpty)? "Sin descripción":playlist.description),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: ()=>Navigator.of(context).pushNamed(MUSIC_DETAIL, arguments: playlist),
    );
  }
}