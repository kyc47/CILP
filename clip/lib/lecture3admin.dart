import 'package:clip/lecture4admin.dart';
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

class Lecture3Admin extends StatefulWidget {
  const Lecture3Admin({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _Lecture3AdminState createState() => _Lecture3AdminState();
}

class _Lecture3AdminState extends State<Lecture3Admin> {
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
    await HCILocation().mouseLog(widget.uid, -1, timeValue);
  }

  int timeValue = 0;

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
    // appContainer!.addEventListener('mouseout', (event) => mouseOut());
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
    '1': [32, 39, 16.8, 44, 10, 26.8], //사회적인
    '2': [202, 209, 13, 63.5, 5.5, 27], //j 긴장했지만,
    '3': [293, 300, 36, 42.5, 5.5, 26], //j 대표팀 주장으로
    '4': [443, 450, 8.5, 62.5, 5.5, 18], //긴장이 수행
    '5': [492, 499, 8, 28, 5.5, 45], //j 자신의 경험
    '6': [586, 593, 8, 49, 5.5, 38], //배컴의 패널트킥
    '7': [693, 700, 14, 60, 5.5, 35.5], //과제 난이도
    '8': [751, 758, 8, 28, 5.5, 64], //j가슴 뛰고
    '9': [945, 952, 9.5, 52.5, 5.5, 43.5], //쉬운과제
    '10': [965, 972, 9.8, 57, 5.5, 44.5], //jj 어려운 과제
    '11': [1230, 1237, 5, 14, 15, 36], //jj 타인의 존재가
    '12': [1313, 1320, 8, 54, 11, 47.5], //타인ㄴ의 존재는 각성증가
    '13': [1375, 1382, 5, 14, 15, 36], //jj 평가불안가설
    '14': [1410, 1417, 8, 52.5, 5.5, 48.2], //타인의 존재가
    '15': [1506, 1513, 5, 14, 15, 38], //jj  주의분산-갈등가설
    '16': [1533, 1540, 8, 42, 5.5, 44], //주의 분산을 일으켜
    '17': [1689, 1697, 8, 35, 11, 44], //jj 복습/쉬운 내용
    '18': [1747, 1754, 8, 47, 5.5, 30.5], //예습
    '19': [0, 0, 0, 0, 0, 0],
  };

  double dx = 0.0;
  double dy = 0.0;
  int timeInt1 = 1;
  List list = [];

  final StopWatchTimer _stopWatchTimer1 = StopWatchTimer();
  double sendTimeValue = 0;

  @override
  Widget build(BuildContext context) {
    Stream.periodic(Duration(seconds: 5), (x) async {
      setState(() {
        if (sendTimeValue > 0) {
          HCILocation()
              .mouseLog(widget.uid, sendTimeValue,
                  _controller.value.position.inSeconds)
              .then((value) => null);
        }
      });
    }).listen((event) {
      sendTimeValue = 0;
    });

    return Material(
        child: Scaffold(
      body: MouseRegion(
        onHover: (PointerEvent details) {
          sendTimeValue = sendTimeValue + details.localDelta.distance;
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              children: [
                VideoPlayer(_controller),
                ClosedCaption(text: _controller.value.caption.text),
                _ControlsOverlay(controller: _controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
                _init
                    ? Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
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
                              primary: Color(0xff041f43),
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
                    return Text(value.position.inSeconds.toString());
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, VideoPlayerValue val, child) {
                    final value = val.position.inSeconds;
                    timeValue = value;
                    list = timeStamp[timeInt1.toString()];
                    if (int.parse(value.toString()) >= 1832) {
                      _stopWatchTimer1.onExecute.add(StopWatchExecute.stop);
                      _stopWatchTimer1.onExecute.add(StopWatchExecute.reset);
                      _controller.removeListener(() {});
                      HCILocation()
                          .getScreen(0, 0, widget.uid, "1 exper end",
                              'experimentslecture')
                          .then((value) {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: Lecture4Admin(uid: widget.uid),
                              inheritTheme: true,
                              ctx: context),
                        );
                      });
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
