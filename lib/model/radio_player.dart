import 'package:audioplayer2/audioplayer2.dart';
import 'package:start_in_flutter/model/radio_channel.dart';
import 'package:start_in_flutter/model/radio_channel_name.dart';

class RadioPlayer {
  AudioPlayer _audioPlayer = new AudioPlayer();
  RadioChannel channel;


  RadioPlayer(){
    channel = new RadioChannel();
    channel.radioChannelName = RadioChannelName.RADIO_RECORD;
  }

  void play(RadioChannel channelName){
    channel = channelName;
    _audioPlayer.play(channelName.urlToAudio);
  }

  void pause() => _audioPlayer.pause();

  void stop() => _audioPlayer.stop();
}