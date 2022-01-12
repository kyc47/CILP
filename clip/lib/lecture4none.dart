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
bool _time1 = false;

class Lecture4None extends StatefulWidget {
  const Lecture4None({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _Lecture4NoneState createState() => _Lecture4NoneState();
}

class _Lecture4NoneState extends State<Lecture4None> {
  late VideoPlayerController _controller;

  static final appContainer =
      html.window.document.getElementById('app-container');

  final stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  int timeValue = 0;

  mouseOut() async {
    await HCILocation().anomalyLog(widget.uid, -1, timeValue);
  }

  @override
  void initState() {
    super.initState();
    _stopWatchTimer1.onExecute.add(StopWatchExecute.start);
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
  final StopWatchTimer _stopWatchTimer1 = StopWatchTimer();
  double sendTimeValue = -1;

  @override
  Widget build(BuildContext context) {
    Stream.periodic(Duration(seconds: 5), (x) async {
      setState(() {
        if (sendTimeValue > 0) {
          HCILocation()
              .anomalyLog(widget.uid, sendTimeValue,
                  _controller.value.position.inSeconds)
              .then((value) => null);
        }
      });
    }).listen((event) {
      sendTimeValue = -1;
    });

    return Material(
      child: Scaffold(
          body: MouseRegion(
        onHover: (PointerEvent details) async {
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
                              await HCILocation().getScreen(0, 0, widget.uid,
                                  'start', 'experimentslecture');
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
                    list = timeStamp[timeInt1.toString()];
                    if (int.parse(value.toString()) >= 1398) {
                      _stopWatchTimer1.onExecute.add(StopWatchExecute.stop);
                      _stopWatchTimer1.onExecute.add(StopWatchExecute.reset);
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
                  return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}