import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:alonsoynovify/music.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  List<Music> myMusicList = [
    Music(
        title: "Chocobo",
        singer: "Square Enix",
        imagePath: "assets/img/chocobo.jpg",
        urlSong: "assets/sound/chocobo.mp3"),
    Music(
        title: "Civilisation",
        singer: "Orelsan",
        imagePath: "assets/img/civilisation.jpg",
        urlSong: "assets/sound/civilisation.mp3"),
    Music(
        title: "Swan Lake",
        singer: "The Agonist",
        imagePath: "assets/img/swan-lake.jpg",
        urlSong: "assets/sound/swan-lake.mp3")
  ];

  int currentTrack = 0;
  final _player = AudioPlayer();
  bool isPlaying = false;
  String duree = "";

  @override
  void initState() {
    super.initState();
    _initSong(currentTrack);
  }

  Future<void> _initSong(currentTrack) async {
    await _player
        .setAsset(myMusicList[currentTrack].urlSong)
        .then((value) => setState(() {
              duree = "${value!.inMinutes}:${value.inSeconds % 60}";
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YNOVIFY'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0b0e15),
      ),
      body: Container(
        color: const Color(0xFF191a2c),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: 300,
              image: AssetImage(myMusicList[currentTrack].imagePath),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              myMusicList[currentTrack].title,
              style: const TextStyle(color: Colors.white, fontSize: 25.0),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              myMusicList[currentTrack].singer,
              style: const TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 45.0,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        (currentTrack == 0)
                            ? currentTrack = myMusicList.length - 1
                            : currentTrack--;
                      });
                      _initSong(currentTrack);
                    },
                    icon: const Icon(
                      Icons.skip_previous,
                    ),
                  ),
                  IconButton(
                    iconSize: 45.0,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        isPlaying = !isPlaying;
                        if (isPlaying) {
                          _player.play();
                        } else {
                          _player.pause();
                        }
                      });
                    },
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  ),
                  IconButton(
                    iconSize: 45.0,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        (currentTrack == myMusicList.length - 1)
                            ? currentTrack = 0
                            : currentTrack++;
                      });
                      _initSong(currentTrack);
                    },
                    icon: const Icon(Icons.skip_next),
                  )
                ]),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              duree,
              style: const TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
