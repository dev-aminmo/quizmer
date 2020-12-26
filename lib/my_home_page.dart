import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlertest/question_provider.dart';
import 'package:flutter/services.dart';
import 'package:quizlertest/ui_helper/my_custom_background.dart';
import 'models/question.dart';
import 'ad_manager.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  QuestionProvider questionProvider;

  Future<void> _initAdMob() {
    // TODO: Initialize AdMob SDK
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAdMob();

      // This line removes status bar SystemChrome.setEnabledSystemUIOverlays([]);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 737, width: 393, allowFontScaling: true);
    return Scaffold(
      body: Container(
        child: buildList(context),
      ),
    );
  }

  Widget buildList(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    questionProvider = Provider.of<QuestionProvider>(context);
    questionProvider.ctx = context;
    // final height = MediaQuery.of(context).size.height;

    return CustomPaint(
      painter: MyCustomBackGround(),
      child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5.0,
              margin: EdgeInsets.only(
                  top: 120.h,
                  //height * 0.2,
                  left: 12.w,
                  right: 12.w,
                  bottom: 42.h),
              color: Color(0xff00AFB8),
              //Colors.deepPurple,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 28.w),
                child: Text(
                  questionProvider.getQuestion().questionText,
                  style: TextStyle(
                    fontFamily: 'MyriadArabic',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 28.sp,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        //color: Colors.grey.shade700,
                        color: Colors.black45,
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            Container(
              //height: 375.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AnswerChoiceWidget(
                      questionProvider: questionProvider, index: 0),
                  AnswerChoiceWidget(
                      questionProvider: questionProvider, index: 1),
                  AnswerChoiceWidget(
                      questionProvider: questionProvider, index: 2),
                  AnswerChoiceWidget(
                      questionProvider: questionProvider, index: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AnswerChoiceWidget extends StatefulWidget {
  AnswerChoiceWidget({@required this.questionProvider, this.index}) {
    question = questionProvider.getQuestion();
    verify = questionProvider.isCorrect;
  }

  final QuestionProvider questionProvider;
  final int index;
  Question question;
  Function verify;

  @override
  _AnswerChoiceWidgetState createState() => _AnswerChoiceWidgetState();
}

class _AnswerChoiceWidgetState extends State<AnswerChoiceWidget> {
  Color answerChosenColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
      width: 300.w,
      child: Card(
        shadowColor: Color(0xeedbdbdb),
        elevation: 2.0,
        color: getColor(),
        child: InkWell(
          enableFeedback: false,
          splashColor: Colors.blueAccent.shade100,
          onTap: (widget.questionProvider.canClick)
              ? () {
                  /*  Future.delayed(Duration(microseconds: 0)).then((value) {
                    widget.questionProvider.changeCanClick(false);
                    setState(() {
                      coular = Color(0xFFfbe7b5);
                    });
                  }).then((value) {
                    Future.delayed(Duration(milliseconds: 50)).then((value) {
                      widget.verify(widget.index);
                    });
                  });
                  */
                  widget.questionProvider.changeCanClick(false);
                  setState(() {
                    //coular = Color(0xFFfbe7b5);

                    answerChosenColor = Color(0xFFFFFADE);
                    // coular = Color(0xFFFFC11E);
                  });
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    widget.verify(widget.index);
                  });
                }
              : null,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 68.w, vertical: 16.h),
            child: Text(
              widget.question.answers[widget.index].answerText,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: 'MyriadArabic',
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    //color: Colors.grey.shade700,
                    color: Colors.black12,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getColor() {
    if (answerChosenColor == null) {
      return widget.questionProvider.buttonColor[widget.index];
    } else {
      var temp = answerChosenColor;
      answerChosenColor = null;
      return temp;
    }
  }
}
