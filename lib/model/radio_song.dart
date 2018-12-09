class RadioSong{
  String title,artist,image;

  RadioSong();

  RadioSong.fromJson(Map<String, dynamic> json){
    title = json["title"] ;
    artist = json["artist"];
    image = json["image600"] !=null
        ? json["image600"]
        : image = "https://picsum.photos/600/600/?random";
  }
}