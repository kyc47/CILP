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
import 'package:url_launcher/url_launcher.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("실험에 참가해주셔서 진심으로 감사드립니다.",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
          Text("아래의 버튼을 눌러, 실험 안내 페이지에 접속해주세요.",style: TextStyle(fontWeight: FontWeight.w700),),
          Text("본 실험 페이지는 종료하셔도 됩니다.",style: TextStyle(fontWeight: FontWeight.w700),),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 50,
                child: Center(child: Text("실험 안내 페이지 바로가기"))),
            onPressed: () async {
              const url =
                  'https://abiding-moustache-7c8.notion.site/5d1581a9232b4ca798c49f4fd1d26a5b';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
