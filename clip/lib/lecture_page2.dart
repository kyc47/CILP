import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class LectureType2 extends StatefulWidget {
  const LectureType2({Key? key}) : super(key: key);

  @override
  _LectureType2State createState() => _LectureType2State();
}

class _LectureType2State extends State<LectureType2> {

  @override
  void initState() {
    _controller.hideTopMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.hideTopMenu();
    return Scaffold(
      body: Container(
        child: Stack(
          children: [

            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: YoutubePlayerIFrame(
                controller: _controller,
                aspectRatio: 16 / 9,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Color(0xa1ffffff)
              ),
              child: GestureDetector(
                onTap: (){
                  print("aa");
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xa1ffffff)
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
            Center(
              child: LikeButton(
                circleColor:
                CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Color(0xff33b5e5),
                  dotSecondaryColor: Color(0xff0099cc),
                ),

                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.home,
                    color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                  );
                },
                likeCount: 665,
              ),
            ),
          ],
        ),
      ),
    );
  }

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'K18cpp_-gP8',
    params: YoutubePlayerParams(
      playlist: [
        'ca_j_CsO14c',
      ],
      // Defining custom playlist
      startAt: Duration(seconds: 30),
      loop:false,
      enableJavaScript: false,
      enableKeyboard: false,
      interfaceLanguage: "KR",
      showControls: false,
      showFullscreenButton: false,
      showVideoAnnotations: false,
    ),
  );
}
