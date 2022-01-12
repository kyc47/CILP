import 'package:clip/lecture1.dart';
import 'package:clip/lecture2.dart';
import 'package:clip/lecture3.dart';
import 'package:clip/lecture3admin.dart';
import 'package:clip/lecture3all.dart';
import 'package:clip/lecture3none.dart';
import 'package:clip/lecture4.dart';
import 'package:clip/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectLecture extends StatefulWidget {
  const SelectLecture({Key? key, required this.uid, required this.type}) : super(key: key);
  final String uid;
  final String type;

  @override
  _SelectLectureState createState() => _SelectLectureState();
}

class _SelectLectureState extends State<SelectLecture> {
  // String uid = "738b9da95dad4de98b3e4566645695f3";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.3,
            bottom: MediaQuery.of(context).size.height * 0.3),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                "실험 시작 전 아래의 내용을 확인해주세요.",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "실험에 참가해주셔서 감사합니다.",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "1. 만약 전체화면이 아니라면 F11을 눌러 전체화면으로 실행해주세요.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "2. 2시간 가량의 시간이 있을 때 실험을 진행해주세요.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '3. 본 실험은 멈추지 않고 진행됩니다. 유의바랍니다.',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '4. 영상이 열리지 않을 경우, 뒤로 가기 후 다시 "실험 시작" 버튼을 눌러주세요.',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: Text(
                      "실험 시작하기",
                      style: TextStyle(color: Colors.white),
                    ))),
                onPressed: () {
                  if (widget.type==1.toString()){
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: Lecture3None(uid: widget.uid),
                          inheritTheme: true,
                          ctx: context),
                    );
                  }
                  if (widget.type==2.toString()){
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: Lecture3(uid: widget.uid),
                          inheritTheme: true,
                          ctx: context),
                    );
                  }
                  if (widget.type==3.toString()){
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: Lecture3All(uid: widget.uid),
                          inheritTheme: true,
                          ctx: context),
                    );
                  }
                  if (widget.type==4.toString()){
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: Lecture3Admin(uid: widget.uid),
                          inheritTheme: true,
                          ctx: context),
                    );
                  }
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
          ],
        ),
      ),
    );
  }
}
