import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/music_list/home_page.dart';
import 'package:spotify_clone/user/first_time_login.dart';
class Splesh extends StatefulWidget {
  const Splesh({Key? key}) : super(key: key);

  @override
  State<Splesh> createState() => _SpleshState();
}

class _SpleshState extends State<Splesh> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Color(0xff111C0B),
      duration: 3000,
        splash: "images/SpotifyLogo.png",splashIconSize: 120,
        nextScreen: homepage()
        // PhoneAuthScreen()
    );
  }
}
