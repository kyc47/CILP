import 'package:clip/finish_test.dart';
import 'package:clip/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:html' as html;
import 'dart:async';
import 'package:stop_watch_timer/stop_watch_timer.dart';

String _url =
    "http://vod.kmoocs.kr/vod/2017/01/06/5abd9481-56f4-43cf-ad96-049a22df17a5.mp4";
bool _time1 = false;

class Counter extends ChangeNotifier {
  int _time = 0;
  Map _timeDis = {};

  int get time => _time;

  Map get timeDis => _timeDis;
}

class LectureCondition2_2 extends StatefulWidget {
  const LectureCondition2_2({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _LectureCondition2_2State createState() => _LectureCondition2_2State();
}

class _LectureCondition2_2State extends State<LectureCondition2_2> {
  late VideoPlayerController _controller;

  static final appContainer =
      html.window.document.getElementById('app-container');

  int timeValue = 0;

  mouseOut() async {
    await HCILocation().outLog(widget.uid, timeValue);
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      _url,
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
    '1': [72, 79, 6, 12, 16, 34.8], //첫번째 선제골은?
    '2': [92, 99, 18.7, 81, 5.5, 6.2], //하석주 jj
    '3': [230, 237, 7.2, 87, 5.5, 9.3], // 반복 연습 jj
    '4': [472, 479, 33, 58.5, 15.7, 36.2], //새가슴. 내용을 모두 학습햇던 사람
    '5': [673, 680, 12, 54.5, 12, 49.5], // 과도학습 jj
    '6': [872, 879, 33, 59, 5.5, 16], //강수진 250켤레 j
    '7': [1013, 1020, 14.8, 55, 10.5, 32.8], //성실하게
    '8': [1123, 1130, 6.5, 5.5, 10, 26.5], //김성주의 노트
    '9': [1222, 1227, 39.5, 48, 17, 29.5], //그 사람이
    '10': [1381, 1388, 8.5, 67.2, 11, 52.7], //관중들의 응원은 jj
    '11': [0, 0, 0, 0, 0, 0],
  };

  int timeInt1 = 1;
  List list = [];
  double sendTimeValue = -1;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => Counter(),
        child: Material(
          child: Scaffold(
              body: Consumer<Counter>(
            builder: (_, counter, __) => MouseRegion(
              onHover: (PointerEvent details) async {
                if (counter._timeDis[
                _controller.value.position.inSeconds] !=
                    null) {
                  counter._timeDis[_controller
                      .value.position.inSeconds] = counter._timeDis[
                  _controller.value.position.inSeconds] +
                      details.localDelta.distance;
                } else {
                  counter._timeDis[_controller.value.position
                      .inSeconds] = details.localDelta.distance;
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: [
                      VideoPlayer(_controller),
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
                                      child: Center(child: Text("실험2 시작하기"))),
                                  onPressed: () async {
                                    setState(() {
                                      _init = false;
                                    });
                                    await HCILocation().getScreen(
                                        0,
                                        0,
                                        widget.uid,
                                        'start2',
                                        'experimentslecture');
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
                        builder: (context, VideoPlayerValue val, child) {
                          final value = val.position.inSeconds;
                          timeValue = value;
                          if (value - 1 == counter._time) {
                            counter._time = counter._time + 1;
                            if (counter._timeDis[value - 1] != null) {
                              HCILocation()
                                  .mouseLog(widget.uid,
                                      counter._timeDis[value - 1], value - 1)
                                  .then((value) => null);
                            }
                          }
                          list = timeStamp[timeInt1.toString()];
                          if (int.parse(value.toString()) >= 1398) {
                            _controller.removeListener(() {});
                            HCILocation()
                                .getScreen(0, 0, widget.uid, "2 exper end",
                                    'experimentslecture')
                                .then((value) {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: FinishScreen(uid: widget.uid),
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
                              HCILocation().getScreen(
                                  0,
                                  0,
                                  widget.uid,
                                  value.toString() +
                                      "sec donot",
                                  'experimentslecture').then((value) => null);
                            }
                            if (int.parse(value.toString()) == list[0]) {
                              _activateButton = true;
                            }

                            return GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   if (_click1a == false) {
                                //     _click1a = true;
                                //   }
                                // });
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
                            if (timeInt1 <= 10) {
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
          )),
        ));
  }
}
