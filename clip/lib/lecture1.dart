import 'package:clip/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';
import 'dart:html' as html;

class Lecture1 extends StatefulWidget {
  const Lecture1({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _Lecture1State createState() => _Lecture1State();
}

class _Lecture1State extends State<Lecture1> {
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
        "http://vod.kmoocs.kr/vod/2020/08/12/ab0b11c7-e60d-453a-a334-10b90fca6791.mp4",
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      // closedCaptionFile: _loadCaptions(),
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
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
  bool _test = true;

  @override
  Widget build(BuildContext context) {
    if (_test) {
      _controller.play().then((value) {
        setState(() {
          _test = false;
        });
      });
    }
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
                _ControlsOverlay(controller: _controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
                // GestureDetector(
                //     onTapDown: (detail) {
                //       x = detail.globalPosition.dx;
                //       y = detail.globalPosition.dy;
                //     },
                //     onDoubleTap: () {
                //       setState(() {});
                //     },
                //     child: Stack(
                //       children: [
                //         CustomPaint(
                //           size: Size(MediaQuery.of(context).size.width,
                //               MediaQuery.of(context).size.height),
                //           painter:
                //               MyPainter(px: x, py: y, width: 400, height: 50),
                //         ),
                //         CustomPaint(
                //           size: Size(MediaQuery.of(context).size.width,
                //               MediaQuery.of(context).size.height),
                //           painter: MyPainter(
                //               px: x, py: y + 100, width: 800, height: 50),
                //         ),
                //       ],
                //     )),
                GestureDetector(
                  onHorizontalDragStart: (detail) {
                    setState(() {
                      x1 = detail.globalPosition.dx.toString();
                      y1 = detail.globalPosition.dy.toString();
                    });
                    // HCILocation()
                    //     .getScreen(x1, y1, widget.uid, "lecture", "screen")
                    //     .then((value) {
                    //   setState(() {
                    //     print("a");
                    //   });
                    // });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Text(
                      x1 + "\n" + y1,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
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

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
