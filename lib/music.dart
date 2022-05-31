class Music {
  Music({
    required this.title,
    required this.singer,
    required this.imagePath,
    required this.urlSong,
  });
  late final String title;
  late final String singer;
  late final String imagePath;
  late final String urlSong;

  Music.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    singer = json['singer'];
    imagePath = json['imagePath'];
    urlSong = json['urlSong'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['singer'] = singer;
    _data['imagePath'] = imagePath;
    _data['urlSong'] = urlSong;
    return _data;
  }
}
