import 'package:clip/lecture4.dart';
import 'package:clip/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';
import 'dart:html' as html;
import 'dart:async';
import 'package:stop_watch_timer/stop_watch_timer.dart';

String _url =
    "http://vod.kmoocs.kr/vod/2020/08/12/ab0b11c7-e60d-453a-a334-10b90fca6791.mp4";
// "http://vod.kmoocs.kr/vod/2017/01/06/5abd9481-56f4-43cf-ad96-049a22df17a5.mp4";
bool _time1 = false;

class Lecture3 extends StatefulWidget {
  const Lecture3({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _Lecture3State createState() => _Lecture3State();
}

class _Lecture3State extends State<Lecture3> {
  late VideoPlayerController _controller;

  // Future<ClosedCaptionFile> _loadCaptions() async {
  //   final String fileContents = await DefaultAssetBundle.of(context)
  //       .loadString('assets/bumble_bee_captions.srt');
  //   return SubRipCaptionFile(fileContents);
  // }

  //
  final stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  static final appContainer =
      html.window.document.getElementById('app-container');

  mouseOut() async {
    await HCILocation().anomalyLog(widget.uid, -1, timeValue);
  }

  @override
  void initState() {
    super.initState();
    _stopWatchTimer1.onExecute.add(StopWatchExecute.start);
    _controller = VideoPlayerController.network(
      _url,
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {});
    _controller.setLooping(false);
    _controller.initialize();
    var focusNode = FocusNode();
    appContainer!.addEventListener('mouseout', (event) => mouseOut());
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
  bool _click1a = false;
  bool _click1b = false;
  bool _activateButton = true;

  bool _init = true;

  Map timeStamp = {
    '1': [32, 39, 16.8, 44, 10, 26.8],
    '2': [202, 209, 13, 63.5, 5.5, 27],
    '3': [293, 300, 36, 42.5, 5.5, 26],
    '4': [454, 461, 8.5, 62.5, 5.5, 18],
    '5': [514, 521, 8, 28, 5.5, 45],
    '6': [609, 616, 8, 49, 5.5, 38], //ㅁㅁ
    '7': [696, 703, 14, 60, 5.5, 35.5],
    '8': [784, 791, 8, 28, 5.5, 64], //가슴 뛰고
    '9': [959, 966, 9.5, 52.5, 5.5, 43.5], //쉬운과제
    '10': [984, 991, 9.8, 57, 5.5, 44.5], //어려운 과제 //확인하기
    '11': [1268, 1275, 5, 14, 15, 36], //11 타인의 존재는 각
    '12': [1321, 1328, 8, 54, 11, 47.5], //각성 증가 //두줄 //확인
    '13': [1385, 1392, 5, 14, 15, 36], //평가불안가설
    '14': [1409, 1416, 8, 52.5, 5.5, 48.2], //타인의 존재가 23.29 23*60+29 1518
    '15': [1518, 1525, 5, 14, 15, 38], //25.18  주의분산
    '16': [1606, 1613, 8, 42, 5.5, 44], //26.46 26*60+46 1606
    '17': [1742, 1749, 8, 35, 11, 44], //29.02 29*60+2 1742
    '18': [1784, 1791, 8, 47, 5.5, 30.5], //29.44 29*60+44 1784
    '19': [0, 0, 0, 0, 0, 0],
  };

  double dx = 0.0;
  double dy = 0.0;
  int timeInt1 = 1;
  List list = [];
  int timeValue = 0;

  final StopWatchTimer _stopWatchTimer1 = StopWatchTimer();
  double temp_value = 0;

  @override
  Widget build(BuildContext context) {
    Stream.periodic(Duration(seconds: 5), (x) async {
      setState(() {
        if (temp_value > 0) {
          HCILocation()
              .anomalyLog(
                  widget.uid, temp_value, _controller.value.position.inSeconds)
              .then((value) => null);
        }
      });
    }).listen((event) {
      temp_value = 0;
    });

    return Material(
        child: Scaffold(
      body: MouseRegion(
        onHover: (PointerEvent details) {
          temp_value = temp_value + details.localDelta.distance;
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              children: [
                VideoPlayer(_controller),
                // ClosedCaption(text: _controller.value.caption.text),
                // _ControlsOverlay(controller: _controller),
                // VideoProgressIndicator(_controller, allowScrubbing: true),
                _init
                    ? Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple[100]!,
                                spreadRadius: 10,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            child: Container(
                                width: double.infinity,
                                height: 50,
                                child: Center(child: Text("실험1 시작하기"))),
                            onPressed: () async {
                              setState(() {
                                _init = false;
                              });
                              await _controller.play();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, VideoPlayerValue value, child) {
                    //Do Something with the value.
                    return Text(value.position.toString());
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, VideoPlayerValue val, child) {
                    final value = val.position.inSeconds;
                    timeValue = value;
                    list = timeStamp[timeInt1.toString()];
                    if (int.parse(value.toString()) > 1833) {
                      _stopWatchTimer1.onExecute.add(StopWatchExecute.stop);
                      _stopWatchTimer1.onExecute.add(StopWatchExecute.reset);
                      _controller.dispose();
                      _controller.removeListener(() {});
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Lecture4(uid: widget.uid),
                            inheritTheme: true,
                            ctx: context),
                      );
                    }
                    if (int.parse(value.toString()) >= list[0] &&
                        int.parse(value.toString()) <= list[1]) {
                      if (_click1a == false &&
                          int.parse(value.toString()) - list[0] > 6) {
                        _click1b = true;
                      }
                      if (int.parse(value.toString()) == list[0]) {
                        _activateButton = true;
                      }

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_click1a == false) {
                              _click1a = true;
                            }
                          });
                        },
                        onTapDown: (TapDownDetails details) async {
                          if (_activateButton) {
                            setState(() {
                              _activateButton = false;
                            });
                            print(details.globalPosition.dx.toDouble());
                            print(details.globalPosition.dy.toDouble());
                          }
                          await HCILocation().getScreen(
                              details.globalPosition.dx.toDouble(),
                              details.globalPosition.dy.toDouble(),
                              widget.uid,
                              value.toString() + "sec_button_touch",
                              'experimentslecture');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   image: AssetImage(_click1a
                            //       ? "assets/images/highlight2.png"
                            //       : "assets/images/highlight1.png"),
                            //   fit: BoxFit.cover,
                            // ),
                            color: _click1a
                                ? Color(0x80C7EA46)
                                : Color(0x80FFA500),
                          ),
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width *
                                  list[2] *
                                  0.01,
                              top: MediaQuery.of(context).size.height *
                                  list[3] *
                                  0.01),
                          height: MediaQuery.of(context).size.height *
                              list[4] *
                              0.01,
                          width: MediaQuery.of(context).size.width *
                              list[5] *
                              0.01,
                        ),
                      );
                    } else if (int.parse(value.toString()) > list[1]) {
                      if (timeInt1 <= 18) {
                        timeInt1 = 1 + timeInt1;
                      }
                      _click1a = false;
                      _click1b = false;
                      return SizedBox();
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
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
                      semanticLabel: 'Play',
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
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
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
