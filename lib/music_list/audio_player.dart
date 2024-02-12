import 'package:spotify_clone/music_data_response.dart';
import 'package:flutter/material.dart';

class mp3_plyr extends StatefulWidget {
  final MusicDataResponse response;
  const mp3_plyr({super.key, required this.response});

  @override
  State<mp3_plyr> createState() => _mp3_plyrState();
}

class _mp3_plyrState extends State<mp3_plyr> {
  final audioPlayer = AudioPlayer();
  bool isplaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    super.initState();
    setAudio() {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.response.image.toString();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              height: MediaQuery.of(context).size.height / 2.75,
              url,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Text(widget.response.title.toString()),
          Text(widget.response.artist.toString()),
          Slider(
              value: position.inSeconds.toDouble(),
              min: 0,
              activeColor: Colors.white,
              max: duration.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                await audioPlayer.resume();
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(position)),
                Text(formatTime(duration-position)),
              ],
            ),
          ),
          CircleAvatar(radius: 35,
            child: IconButton(onPressed: () async {
              if(isplaying){
                await audioPlayer.pause;
              }
              else{
                audioPlayer.resume;
              }
            }, icon: Icon(isplaying?Icons.pause:Icons.play_arrow)
            ),
          )
        ],
      ),
    );
  }
  Future<void>setAudio() async{
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    await audioPlayer.setSourceUrl(widget.response.source.toString());
  }
  String formatTime(Duration duration){
    String twodigits(int n) => n.toString().padLeft(2,"0");
    final hours = twodigits(duration.inHours);
    final twodigitsMinutes=twodigits(duration.inMinutes.remainder(60));
    final twodigitsSeconds=twodigits(duration.inSeconds.remainder(60));
    return [if(duration.inHours>0)hours,twodigitsMinutes,twodigitsSeconds].join(':');

  }
}