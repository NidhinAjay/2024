import 'package:flutter/material.dart';
import 'package:spotify_clone/api_service.dart';
import 'package:spotify_clone/music_data_response.dart';
import 'package:spotify_clone/music_list/audio_player.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<MusicDataResponse> musicList = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final music_List = await musicapi().musicfunction();
    setState(() {
      musicList = music_List;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff111C0B),
      appBar: AppBar(
        backgroundColor: Color(0xff111C0B),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildfeaturedplaylist(),
          Divider(height: 5),
          Expanded(child: ListView.builder(
            shrinkWrap: true,
            itemCount: musicList.length,
            itemBuilder: (context, index) {
              return InkWell(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => mp3_plyr(response: musicList[index])));
              },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(child: FadeInImage.assetNetwork(
                          height: 50,width: 50,
                          placeholder: "images/SpotifyLogo.png",
                          image: musicList[index].image.toString(),fit: BoxFit.fill,),
                      ),
                    ),
                    Flexible(child: Column(children: [
                      Text(musicList[index].title.toString()),
                      Text(musicList[index].artist.toString())
                    ],))
                  ],
                )
              );
            },))
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("Nidhin Ajay"),
              accountEmail: Text("nidhinajay1253@gmail.com")),
          ListTile(
            title: Text("What's new"),
            leading: Icon(Icons.flash_on_outlined),
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          ListTile(
            title: Text("Listening history"),
            leading: Icon(Icons.timelapse_outlined),
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          ListTile(
            title: Text("Settings and privacy"),
            leading: Icon(Icons.settings_outlined),
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.white,
          unselectedItemColor: Colors.white60,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => home()));
                  },
                  child: Icon(
                    Icons.home,
                  )),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => notif()));
                  },
                  child: Icon(Icons.search)),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Account()));
                  },
                  child: Icon(Icons.label_outline_rounded)),
              label: 'Your Library',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => cart()));
                  },
                  child: Icon(Icons.workspace_premium)),
              label: 'Premium',
            ),
          ]),
    );
  }

  Widget buildfeaturedplaylist() {
    return Column(
      children: [
        Text('playlist'),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 120,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Center(child: Text('play list $index')),
              );
            },
          ),
        ),
      ],
    );
  }
}
