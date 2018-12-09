import 'package:audioplayer2/audioplayer2.dart';
import 'package:start_in_flutter/model/radio_channel.dart';

class RadioPlayer {
  AudioPlayer _audioPlayer = new AudioPlayer();
  RadioChannel channel;

  void play(RadioChannel channelName){
    channel = channelName;
    _audioPlayer.play(channelName.urlToAudio);
  }

  void pause() => _audioPlayer.pause();

  void stop() => _audioPlayer.stop();
}