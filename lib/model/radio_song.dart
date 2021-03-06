class RadioSong {
  String title, artist, image;

  RadioSong(){
    _check();
  }



  RadioSong.fromJson(Map<String, dynamic> json) {
    print("json = "+json.values.toString());
      title = json["title"];
      artist = json["artist"];
      image = json["image600"] != null
          ? json["image600"]
          : image = "https://picsum.photos/600/600/?random";
  }
  _check(){
    if(title == "" && artist == ""){
      title = "";
      artist = "";
      image = "https://picsum.photos/600/600/?random";
    }
  }
}
