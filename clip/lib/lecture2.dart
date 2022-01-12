import 'package:clip/finish_test.dart';
import 'package:clip/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';
import 'dart:html' as html;
import 'dart:async';
import 'package:stop_watch_timer/stop_watch_timer.dart';

String _url =
// "http://vod.kmoocs.kr/vod/2020/08/12/ab0b11c7-e60d-453a-a334-10b90fca6791.mp4";
    "http://vod.kmoocs.kr/vod/2017/01/06/5abd9481-56f4-43cf-ad96-049a22df17a5.mp4";

class Lecture2 extends StatefulWidget {
  const Lecture2({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _Lecture2State createState() => _Lecture2State();
}

class _Lecture2State extends State<Lecture2> {
  late VideoPlayerController _controller;

  Future<ClosedCaptionFile> _loadCaptions() async {
    final String fileContents = await DefaultAssetBundle.of(context)
        .loadString('assets/bumble_bee_captions.srt');
    return SubRipCaptionFile(fileContents);
  }

  //
  final stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
  );

  @override
  void initState() {
    super.initState();

    _stopWatchTimer1.onExecute.add(StopWatchExecute.start);

    _controller = VideoPlayerController.network(
      _url,
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
  bool _click1a = false;
  bool _click1b = false;

  bool _init = true;

  Map timeStamp2 = {
    '1': [45, 52, 46, 73, 5.5, 10],
    '2': [230, 237, 11, 86.5, 5.5, 8],
    '3': [480, 487, 35, 75, 5.5, 22],
    '4': [672, 679, 17, 55, 5.5, 7.5],
    '5': [890, 897, 35, 80, 5.5, 22],
    '6': [995, 1002, 18, 48.5, 6, 20],
    '7': [1230, 1237, 42, 76, 5.5, 16],
    '8': [1380, 1387, 37.5, 47, 5.5, 20],
    '9': [0, 0, 0, 0, 0, 0],
  };
  int timeInt1 = 1;
  List list = [];

  final StopWatchTimer _stopWatchTimer1 = StopWatchTimer();
  @override
  Widget build(BuildContext context) {
    if (_init) {
      _controller.play().then((value) {
        setState(() {
          _init = false;
        });
      });
    }
    return Material(
      child: Scaffold(
          body: Stack(
            children: [
              VideoPlayer(_controller),
              ClosedCaption(text: _controller.value.caption.text),
              VideoProgressIndicator(_controller, allowScrubbing: true),
              // _controlsonontrolsOverlay(controller: _controller),
              StreamBuilder<int>(
                stream: _stopWatchTimer1.secondTime,
                initialData: 0,
                builder: (context, snap) {
                  final value = snap.data;
                  list = timeStamp2[timeInt1.toString()];

                  // if(int.parse(value.toString())>1400){
                  if (int.parse(value.toString()) > 55) {
                    _stopWatchTimer1.onExecute.add(StopWatchExecute.stop);
                    _stopWatchTimer1.onExecute.add(StopWatchExecute.reset);
                    _controller.dispose();
                    _controller.removeListener(() {});
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: FinishScreen(uid: widget.uid),
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
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_click1a == false) {
                            _click1a = true;
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: _click1a
                                ? Color(0xa0ff00ff)
                                : Color(0xa0ff0000)),
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width *
                                list[2] *
                                0.01,
                            top: MediaQuery.of(context).size.height *
                                list[3] *
                                0.01),
                        width:
                            MediaQuery.of(context).size.width * list[5] * 0.01,
                        height:
                            MediaQuery.of(context).size.height * list[4] * 0.01,
                      ),
                    );
                  } else if (int.parse(value.toString()) > list[1]) {
                    if (timeInt1 <= 8) {
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

              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
              ),
              // Container(
              //   margin:
              //       EdgeInsets.only(top: ViewPort.of(context).height * 0.3),
              //   height: 1,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(top: ViewPort.of(context).height * 0.4),
              //   height: 1,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(top: ViewPort.of(context).height * 0.5),
              //   height: 1,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(top: ViewPort.of(context).height * 0.6),
              //   height: 1,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(top: ViewPort.of(context).height * 0.7),
              //   height: 1,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(top: ViewPort.of(context).height * 0.8),
              //   height: 1,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(top: ViewPort.of(context).height * 0.9),
              //   height: 1,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.red,
              // ),
              // // ////
              // Container(
              //   margin: EdgeInsets.only(
              //       left: ViewPort.of(context).width * 0.05),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(left: ViewPort.of(context).width * 0.1),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin: EdgeInsets.only(
              //       left: ViewPort.of(context).width * 0.15),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(left: ViewPort.of(context).width * 0.2),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin: EdgeInsets.only(
              //       left: ViewPort.of(context).width * 0.25),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(left: ViewPort.of(context).width * 0.3),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin: EdgeInsets.only(
              //       left: ViewPort.of(context).width * 0.35),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(left: ViewPort.of(context).width * 0.4),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.45),
                height: MediaQuery.of(context).size.height,
                width: 1,
                color: Colors.red,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.5),
                height: MediaQuery.of(context).size.height,
                width: 1,
                color: Colors.red,
              ),
              // Container(
              //   margin: EdgeInsets.only(
              //       left: ViewPort.of(context).width * 0.55),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(left: ViewPort.of(context).width * 0.6),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin: EdgeInsets.only(
              //       left: ViewPort.of(context).width * 0.65),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(left: ViewPort.of(context).width * 0.7),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin: EdgeInsets.only(
              //       left: ViewPort.of(context).width * 0.75),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(left: ViewPort.of(context).width * 0.8),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin: EdgeInsets.only(
              //       left: ViewPort.of(context).width * 0.85),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
              // Container(
              //   margin:
              //       EdgeInsets.only(left: ViewPort.of(context).width * 0.9),
              //   height: MediaQuery.of(context).size.height,
              //   width: 1,
              //   color: Colors.red,
              // ),
            ],
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            // 재생/일시 중지 기능을 `setState` 호출로 감쌉니다. 이렇게 함으로써 올바른 아이콘이
            // 보여집니다.
            setState(() {
              // 영상이 재생 중이라면, 일시 중지 시킵니다.
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                // 만약 영상이 일시 중지 상태였다면, 재생합니다.
                _controller.play();
              }
            });
          })),
    );
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
