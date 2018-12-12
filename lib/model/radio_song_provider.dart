import 'package:start_in_flutter/model/radio_channel.dart';
import 'package:start_in_flutter/model/radio_channel_name.dart';
import 'package:start_in_flutter/model/radio_song.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RadioSongProvider{
  Map<RadioChannelName, RadioChannel> _radioMapChannels;

  RadioChannelName _currentChannel;
  RadioSong _currentSong;
                //constructor
//todo 2 38 49 https://www.youtube.com/watch?v=nxvKANc3Ycg
  RadioSongProvider(){
    _initSongMap();
    _initCurrentChannel();
  }

                //get set
// list name channel
  Map<RadioChannelName, RadioChannel> get radioMapChannels => _radioMapChannels;

//  текущая песня
  RadioSong get currentSong => _currentSong !=null ? _currentSong : new RadioSong();

//  текущий канал

  RadioChannel getCurrentChannel() => _radioMapChannels[_currentChannel];


  set currentChannel(RadioChannelName value) {
    _currentChannel = value;
    updateSongCurrentChannel();
  }

                //methord

  void updateSongCurrentChannel() async {
    RadioChannel channel = _radioMapChannels[_currentChannel];
//    асинхронный опирация
    print("url info = "+channel.urlToInfo);
    http.Response response = channel.urlToInfo !=null ?  await http.get(channel.urlToInfo) : "";
//    http.Response response = await http.get(channel.urlToInfo);
    _currentSong =  _parseIntoHttpResponse(response);

  }

  // get set http
  RadioSong _parseIntoHttpResponse(http.Response httpResponse){
    String httpResult = httpResponse.body;

    Map songMap = json.decode(httpResult);
    return RadioSong.fromJson(songMap);
  }

  void _initCurrentChannel() {
    _currentChannel = RadioChannelName.RADIO_RECORD;
  }

  void _initSongMap(){
    _radioMapChannels = new Map();
    RadioChannel radioRecordChannel = new RadioChannel();
    radioRecordChannel.nameChannel = "Radio Record";
    radioRecordChannel.urlToInfo = "http://www.radiorecord.ru/xml/rr_online_v8.txt";
    radioRecordChannel.urlToAudio = "http://air.radiorecord.ru:805/rr_320";
    radioRecordChannel.radioChannelName = RadioChannelName.RADIO_RECORD;
    _radioMapChannels[RadioChannelName.RADIO_RECORD] = radioRecordChannel;

    RadioChannel radioChillChannel = new RadioChannel();
    radioChillChannel.nameChannel = "Radio Chill House";
    radioChillChannel.urlToInfo = "http://www.radiorecord.ru/xml/chillhouse_online_v8.txt";
    radioChillChannel.urlToAudio = "http://air.radiorecord.ru:805/chillhouse_320";
    radioChillChannel.radioChannelName = RadioChannelName.CHILL_HOUSE;
    _radioMapChannels[RadioChannelName.CHILL_HOUSE] = radioChillChannel;

    RadioChannel radioRussianChannel = new RadioChannel();
    radioRussianChannel.nameChannel = "Radio Russian Mix";
    radioRussianChannel.urlToInfo = "http://www.radiorecord.ru/xml/russianhits_online_v8.txt";
    radioRussianChannel.urlToAudio = "http://air.radiorecord.ru:805/russianhits_320";
    radioRussianChannel.radioChannelName = RadioChannelName.RUSSIAN_MIX;
    _radioMapChannels[RadioChannelName.RUSSIAN_MIX] = radioRussianChannel;

    RadioChannel radioTranceChannel = new RadioChannel();
    radioTranceChannel.nameChannel = "Radio Trance Hits";
    radioTranceChannel.urlToInfo = "http://www.radiorecord.ru/xml/trancehits_online_v8.txt";
    radioTranceChannel.urlToAudio = "http://air.radiorecord.ru:805/trancehits_320";
    radioTranceChannel.radioChannelName = RadioChannelName.TRANCE_HITS;
    _radioMapChannels[RadioChannelName.TRANCE_HITS] = radioTranceChannel;
//    add castom radio
    RadioChannel xitFMChannel = new RadioChannel();
    xitFMChannel.nameChannel = "Radio XIT Fm";
    xitFMChannel.urlToInfo = "";
    xitFMChannel.urlToAudio = "https://hitfm.hostingradio.ru/hitfm96.aacp?0.5619236471240208";
    xitFMChannel.radioChannelName = RadioChannelName.XIT_FM;
    _radioMapChannels[RadioChannelName.XIT_FM] = xitFMChannel;

    RadioChannel bigChannel = new RadioChannel();
    bigChannel.nameChannel = "Radio Big 20";
    bigChannel.urlToInfo = "";
    bigChannel.urlToAudio = "http://hitfmradio.gcdn.co/st02.mp3/icecast.audio?0.9251112144468552";
    bigChannel.radioChannelName = RadioChannelName.BIG_20;
    _radioMapChannels[RadioChannelName.BIG_20] = bigChannel;

    RadioChannel xitFmSoftChannel = new RadioChannel();
    xitFmSoftChannel.nameChannel = "Radio Xit Fm soft";
    xitFmSoftChannel.urlToInfo = "";
    xitFmSoftChannel.urlToAudio = "http://hitfmradio.gcdn.co/st14.mp3/icecast.audio?0.22874647962701422";
    xitFmSoftChannel.radioChannelName = RadioChannelName.XIT_FM_SOFT;
    _radioMapChannels[RadioChannelName.XIT_FM_SOFT] = xitFmSoftChannel;

    RadioChannel xitFmDanceChannel = new RadioChannel();
    xitFmDanceChannel.nameChannel = "Radio Xit Fm Dance";
    xitFmDanceChannel.urlToInfo = "";
    xitFmDanceChannel.urlToAudio = "http://hitfmradio.gcdn.co/st33.mp3/icecast.audio?0.929252074951488";
    xitFmDanceChannel.radioChannelName = RadioChannelName.XIT_FM_DANCE;
    _radioMapChannels[RadioChannelName.XIT_FM_DANCE] = xitFmDanceChannel;

    RadioChannel xitFmTopChannel = new RadioChannel();
    xitFmTopChannel.nameChannel = "Radio Xit Fm Top Ykr";
    xitFmTopChannel.urlToInfo = "";
    xitFmTopChannel.urlToAudio = "http://online-hitfm2.tavrmedia.ua/HitFM_Top";
    xitFmTopChannel.radioChannelName = RadioChannelName.XIT_FM_TOP_YKR;
    _radioMapChannels[RadioChannelName.XIT_FM_TOP_YKR] = xitFmTopChannel;

  }
}