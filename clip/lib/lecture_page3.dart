import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:video_player/video_player.dart';
import 'dart:html' as html;

class LectureType3 extends StatefulWidget {
  const LectureType3({Key? key}) : super(key: key);

  @override
  _LectureType3State createState() => _LectureType3State();
}

class _LectureType3State extends State<LectureType3> {
  int _enterCounter = 0;
  int _exitCounter = 0;
  double x = 0.0;
  double y = 0.0;

  void _incrementEnter(PointerEvent details) {
    setState(() {
      _enterCounter++;
    });
  }

  void _incrementExit(PointerEvent details) {
    setState(() {
      _exitCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  void _updateLocation1(PointerEvent details) {
    x = details.position.dx;
    y = details.position.dy;
  }

  void _in1(PointerEvent details) {
    area3x = details.position.dx;
  }

  void _out1(PointerEvent details) {
    area3xx = details.position.dx;
    setState(() {
      print(area3xx - area3x);
      if (area3xx - area3x > MediaQuery.of(context).size.width * 0.13) {
        dragLtoR = true;
      }
    });
  }

  void _in2(PointerEvent details) {
    area4x = details.position.dx;
    print("area4x : ${area4x.toString()}");
  }

  void _out2(PointerEvent details) {
    area4xx = details.position.dx;
    setState(() {
      print(area4x - area4xx);
      if (area4x - area4xx > MediaQuery.of(context).size.width * 0.13) {
        dragRtoL = true;
      }
    });
  }

  void _in3(PointerEvent details) {
    area5y = details.position.dy;
  }

  void _out3(PointerEvent details) {
    area5yy = details.position.dy;
    setState(() {
      print(area5y - area5yy);
      if (area5yy - area5y > MediaQuery.of(context).size.height * 0.13) {
        dragTtoB = true;
      }
    });
  }

  void _in4(PointerEvent details) {
    area6y = details.position.dy;
    print("area6y : ${area6y.toString()}");
  }

  void _out4(PointerEvent details) {
    area6yy = details.position.dy;
    print("area6yy : ${area4xx.toString()}");
    setState(() {
      print(area6y - area6yy);
      if (area6y - area6yy > MediaQuery.of(context).size.height * 0.13) {
        dragBtoT = true;
      }
    });
  }

  void _in5(PointerEvent details) {
    area7y = details.position.dy;
    area7x = details.position.dx;
    print("area7y : ${area6y.toString()}");
  }

  void _out5(PointerEvent details) {
    area7yy = details.position.dy;
    area7xx = details.position.dx;
    print("area7yy : ${area4xx.toString()}");
    setState(() {
      print(area7y - area7yy);
      print(area7x - area7xx);
      if (area7yy - area7y > MediaQuery.of(context).size.height * 0.04) {
        if (area7xx - area7x > MediaQuery.of(context).size.width * 0.04) {
          dragShape = true;
        }
      }
    });
  }

  late VideoPlayerController _controller;

  //
  String areal1x = "", areal1y = "";
  String areag1x = "", areag1y = "";
  String area2x = "", area2y = "";
  double area3x = 0, area3xx = 0;
  double area4x = 0, area4xx = 0;
  double area5y = 0, area5yy = 0;
  double area6y = 0, area6yy = 0;
  double area7x = 0, area7xx = 0, area7y = 0, area7yy = 0;

  bool hovor1 = false;
  bool dragLtoR = false;
  bool dragRtoL = false;
  bool dragTtoB = false;
  bool dragBtoT = false;
  bool dragShape = false;

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
      "http://vod.kmoocs.kr/vod/2017/01/05/a4c4e175-91b9-432e-a77c-3cb688222338.mp4?1629173947768",
      closedCaptionFile: _loadCaptions(),
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
                _ControlsOverlay(controller: _controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                      onTap: () {},
                      onHover: (value) {
                        setState(() {
                          hovor1 = !hovor1;
                          // isHovez = value;
                        });
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.25,
                          color: Color(0x44ffff00),
                          child: Center(
                            child: Text(hovor1 ? "호버링 ON" : "호버링 OFF"),
                          ))),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(Size(
                        MediaQuery.of(context).size.width * 0.25,
                        MediaQuery.of(context).size.height * 0.25)),
                    child: MouseRegion(
                      onEnter: _incrementEnter,
                      onHover: _updateLocation,
                      onExit: _incrementExit,
                      child: Container(
                        color: Colors.lightBlueAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '들어온 횟수 : $_enterCounter \n나간 횟수 : $_exitCounter ',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              '좌표\n x: ${x.toStringAsFixed(2)}\ny: ${y.toStringAsFixed(2)}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.10,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.1),
                    decoration: BoxDecoration(color: Color(0x44ffff00)),
                    child: MouseRegion(
                      onEnter: _in1,
                      onExit: _out1,
                      child: Container(
                          color: Colors.lightBlueAccent,
                          child: Column(
                            children: [
                              Text(
                                "왼쪽에서 오른쪽 확인  : ${dragLtoR ? "성공" : "미수행"}",
                              ),
                              TextButton(
                                child: Text(
                                  '초기화',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () {
                                  setState(() {
                                    dragLtoR = false;
                                  });
                                },
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.10,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1),
                    decoration: BoxDecoration(color: Color(0x44ffff00)),
                    child: MouseRegion(
                      onEnter: _in2,
                      onExit: _out2,
                      child: Container(
                          color: Colors.lightBlueAccent,
                          child: Column(
                            children: [
                              Text(
                                "오른쪽에서 왼쪽 확인  : ${dragRtoL ? "성공" : "미수행"}",
                              ),
                              TextButton(
                                child: Text(
                                  '초기화',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () {
                                  setState(() {
                                    dragRtoL = false;
                                  });
                                },
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.10,
                    height: MediaQuery.of(context).size.height * 0.15,
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                      bottom: MediaQuery.of(context).size.height * 0.1,
                    ),
                    decoration: BoxDecoration(color: Color(0x44ffff00)),
                    child: MouseRegion(
                      onEnter: _in3,
                      onExit: _out3,
                      child: Container(
                          color: Colors.lightBlueAccent,
                          child: Column(
                            children: [
                              Text(
                                "위에서 아래 확인  : ${dragTtoB ? "성공" : "미수행"}",
                              ),
                              TextButton(
                                child: Text(
                                  '초기화',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () {
                                  setState(() {
                                    dragTtoB = false;
                                  });
                                },
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.10,
                    height: MediaQuery.of(context).size.height * 0.15,
                    margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.1,
                      bottom: MediaQuery.of(context).size.height * 0.1,
                    ),
                    decoration: BoxDecoration(color: Color(0x44ffff00)),
                    child: MouseRegion(
                      onEnter: _in4,
                      onExit: _out4,
                      child: Container(
                          color: Colors.lightBlueAccent,
                          child: Column(
                            children: [
                              Text(
                                "아래에서 위 확인  : ${dragBtoT ? "성공" : "미수행"}",
                              ),
                              TextButton(
                                child: Text(
                                  '초기화',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () {
                                  setState(() {
                                    dragBtoT = false;
                                  });
                                },
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(color: Color(0x44ffff00)),
                    child: MouseRegion(
                      onEnter: _in5,
                      onExit: _out5,
                      child: Container(
                          color: Colors.lightBlueAccent,
                          child: Column(
                            children: [
                              Text(
                                "ㄴ자 만들기  : ${dragShape ? "성공" : "미수행"}",
                              ),
                              TextButton(
                                child: Text(
                                  '초기화',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () {
                                  setState(() {
                                    dragShape = false;
                                  });
                                },
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.1),
                //   height: 1,
                //   width: MediaQuery.of(context).size.width,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.2),
                //   height: 1,
                //   width: MediaQuery.of(context).size.width,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.3),
                //   height: 1,
                //   width: MediaQuery.of(context).size.width,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.4),
                //   height: 1,
                //   width: MediaQuery.of(context).size.width,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.5),
                //   height: 1,
                //   width: MediaQuery.of(context).size.width,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.6),
                //   height: 1,
                //   width: MediaQuery.of(context).size.width,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.7),
                //   height: 1,
                //   width: MediaQuery.of(context).size.width,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.8),
                //   height: 1,
                //   width: MediaQuery.of(context).size.width,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.9),
                //   height: 1,
                //   width: MediaQuery.of(context).size.width,
                //   color: Colors.red,
                // ),
                // ////
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.05),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.1),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.15),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.2),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.25),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.3),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.35),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.4),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.45),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.5),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.55),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.6),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.65),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.7),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.75),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.8),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.85),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.9),
                //   height: MediaQuery.of(context).size.height,
                //   width: 1,
                //   color: Colors.red,
                // ),
              ],
            ),
          ),
        ),
      ),
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
