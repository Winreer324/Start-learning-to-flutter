import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:start_in_flutter/model/radio_channel.dart';
import 'package:start_in_flutter/model/radio_player.dart';
import 'package:start_in_flutter/model/radio_song_provider.dart';

class HomePage extends StatefulWidget {
//StatefulWidget = view


  @override
  State createState() => _HomePageState();
}
// - = private
class _HomePageState extends State<HomePage> {

  RadioSongProvider _provider;
  RadioPlayer _player;

  @override
  void initState() {
//    без него не будет работать
    super.initState();
    _provider = new RadioSongProvider();
    _player = new RadioPlayer();
    _player.play(_provider.getCurrentChannel());
// обновление картинки и тд

    Timer.periodic( Duration(seconds: 5), (timer) =>
        setState((){
//          делает перестройку всего дизайна !!
          _provider.updateSongCurrentChannel();
        })
    );
  }
//todo пофиксить вывод инфы радио которые добавленны
  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    var iterableElements = _provider.radioMapChannels.values;
    var listChannel = iterableElements.toList();

    listChannel.sort((c1, c2) => c1.nameChannel.compareTo(c2.nameChannel));

    for (int i = 0; i < iterableElements.length; i++) {
      var channel = listChannel[i];
//        active channel
      var backgroundColor = channel.nameChannel.toString() ==
          _player.channel.nameChannel.toString()
          ? Colors.black38
          : Colors.white;

print(_provider.getCurrentChannel());
      drawerOptions.add(
          Container(
            decoration: BoxDecoration(color: backgroundColor),
            child: ListTile(
                title: Text(
                  channel.nameChannel,
                  style: TextStyle(color: Color(0xFF212121)),
                ),
                onTap: () => _onSelectChangeChannel(channel) ,
            )
          ));
    }

    return new Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(_provider
            .getCurrentChannel()
            .nameChannel),
      ),
//    drawer = меню для свайпа
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
//          DrawerHeader панелька типа инфа о пользователе
            DrawerHeader(
              decoration: BoxDecoration(
                  color: Color(0xFF212121)
              ),
              child: Center(
                child: Text(
                  _provider
                      .getCurrentChannel()
                      .nameChannel,
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            Column(children: drawerOptions,)
          ],
        ),
      ),
      body: GestureDetector(
//        listener ????
        onTap: () => _player.play(_provider.getCurrentChannel()),
        onDoubleTap: () => _player.pause(),
//        stack для многопоточности
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
//                      сравнение на null
                        _provider.currentSong.image ?? ""
                    ),
                    fit: BoxFit.fitHeight
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4.0,sigmaY: 4.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.75)),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Card(
                    shape: Border.all(color: Colors.white, width: 2.0,style: BorderStyle.solid),
                    child: Image.network(
                        _provider.currentSong.image ?? ""
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24,top: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _provider.currentSong.title ?? _provider.getCurrentChannel().nameChannel,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24,top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _provider.currentSong.artist ??_provider.getCurrentChannel().nameChannel ,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  _onSelectChangeChannel(RadioChannel channel){
    setState( () {
      _provider.currentChannel = channel.radioChannelName;
      _player.stop();
      _player.play(_provider.getCurrentChannel());

      print("set title = "+_provider.currentSong.title+"artist = "+_provider.currentSong.artist+"\n");

    });
    Navigator.pop(context);
  }
}