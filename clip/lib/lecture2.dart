import 'package:clip/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';
import 'dart:html' as html;


class Lecture2 extends StatefulWidget {
  const Lecture2({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _Lecture2State createState() => _Lecture2State();
}

class _Lecture2State extends State<Lecture2> {
  late VideoPlayerController _controller;

  //

  //
  Future<ClosedCaptionFile> _loadCaptions() async {
    final String fileContents = await DefaultAssetBundle.of(context)
        .loadString('assets/bumble_bee_captions.srt');
    return SubRipCaptionFile(fileContents);
  }

  //
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      // 'https://vsu.play.kakao.com/vod/vcfe5In0dB00BP7B5aa005b/mp4/mp4_720P_2M_T1/clip.mp4?px-time=1628506206&px-bps=5687617&px-bufahead=12&px-hash=c5ea3cdd4c489563c5489e3bc59b4da5',
      // 'http://vod.kmoocs.kr/vod/2017/01/05/a4c4e175-91b9-432e-a77c-3cb688222338.mp4?1629173947768',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String test = "on";
  double x = 0;
  double y = 0;
  String x1 = "0";
  String y1 = "0";
  bool _click = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: AspectRatio(
            aspectRatio: 1.0,
            // aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),
                ClosedCaption(text: _controller.value.caption.text),
                // _ControlsOverlay(controller: _controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
                GestureDetector(
                    onTapDown: (detail) {
                      x = detail.globalPosition.dx;
                      y = detail.globalPosition.dy;
                    },
                    onDoubleTap: () {
                      setState(() {});
                    },
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height),
                          painter:
                              MyPainter(px: x, py: y, width: 400, height: 50),
                        ),
                        GestureDetector(
                          onTap: ()async{
                            //서버로 데이터전송 기능
                            //3초정도 안에 안누르면 자동으로 버튼사라지게하는 기능
                            // await Future.delayed(const Duration(seconds: 3), (){
                            //   if(!_click){
                            //     _click = true;
                            //   }
                            // });
                          },
                          child: CustomPaint(
                            size: Size(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height),
                            painter: MyPainter(
                                px: x, py: y + 100, width: 800, height: 50),
                          ),
                        )
                      ],
                    )),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter(
      {@required this.px,
        @required this.py,
        @required this.width,
        @required this.height});

  final double? px;
  final double? py;
  final double? width;
  final double? height;

  @override
  void paint(Canvas canvas, Size size) {
    var myPaint = Paint();
    myPaint.color = Color(0xa0ffd400);
    myPaint.strokeWidth = height ?? 0;
    canvas.drawLine(
        Offset(px ?? 0, py ?? 0),
        Offset((px ?? 0).toDouble() + (width ?? 0).toDouble(),
            (py ?? 0).toDouble()),
        myPaint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
