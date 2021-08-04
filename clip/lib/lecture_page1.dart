import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class LectureTypeA extends StatefulWidget {
  const LectureTypeA({Key? key}) : super(key: key);

  @override
  _LectureTypeAState createState() => _LectureTypeAState();
}

class _LectureTypeAState extends State<LectureTypeA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: YoutubePlayerIFrame(
                controller: _controller,
                aspectRatio: 16 / 9,
              ),
            )
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
      showControls: false,
      showFullscreenButton: true,
      showVideoAnnotations: false,
    ),
  );
}
