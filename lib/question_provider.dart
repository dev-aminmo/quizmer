import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quizlertest/models/question.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ad_manager.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionProvider with ChangeNotifier {
  InterstitialAd _interstitialAd;
  Box<Question> _db;
  bool isInitialized;
  int index;
  int length;
  bool canClick = true;
  int adCounter = 0;
  SharedPreferences sharedPreferences;
  BuildContext ctx;

  void _loadInterstitialAd() {
    _interstitialAd = createInterstitialAd();
    _interstitialAd.load();
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: (MobileAdEvent event) {
        print('***********************************************');
        print('***********************$event***************');
        print('***********************************************');
      },
    );
  }

  void showInterAd() {
    _interstitialAd.show(
      horizontalCenterOffset: 0,
      anchorOffset: 0,
      anchorType: AnchorType.bottom,
    );
  }

  bool canShowAd() {
    if (adCounter == 4) {
      print('adCounter=$adCounter');
      adCounter = 0;
      return true;
    } else if (adCounter == 3) {
      adCounter++;
      return false;
    } else if (adCounter == 0) {
      print('adCounter=$adCounter');
      adCounter++;
      _loadInterstitialAd();
      return false;
    } else {
      print('adCounter=$adCounter');
      adCounter++;
      return false;
    }
  }

  List<Color> buttonColor = [
    Color(0xFFdbdbdb),
    Color(0xFFdbdbdb),
    Color(0xFFdbdbdb),
    Color(0xFFdbdbdb),
  ];
  Color _TRUECOLOR = Color(0xFF4CAF50);

  Color _FALSECOLOR = Color(0xFFF44336);

  QuestionProvider(db, init, sh) {
    _db = db as Box<Question>;
    isInitialized = init;
    length = _db.length;
    sharedPreferences = sh;
  }

  Question getQuestion() {
    index = sharedPreferences.getInt('savedIndex');
    if (index == null) {
      index = 0;
    }
    return _db.getAt(index);
  }

  void changeCanClick(bool b) {
    canClick = b;
    notifyListeners();
  }

  Future<bool> isLoadedFin() async {
    if (await _interstitialAd.isLoaded()) {
      return true;
    } else {
      return false;
    }
  }

  void nextQuestion() async {
    if (canShowAd() && await isLoadedFin() && _interstitialAd != null) {
      showInterAd();
    }
    buttonColor = [
      Color(0xFFdbdbdb),
      Color(0xFFdbdbdb),
      Color(0xFFdbdbdb),
      Color(0xFFdbdbdb),
    ];
    if (index < length - 1) {
      index++;
      sharedPreferences.setInt('savedIndex', index);
      notifyListeners();
    } else {
      Alert(
          title: 'تهانينا',
          style: AlertStyle(
              isCloseButton: false,
              titleStyle: TextStyle(
                  fontFamily: 'MyriadArabic',
                  fontWeight: FontWeight.w400,
                  fontSize: 32)),
          context: ctx,
          content: Column(
            children: <Widget>[
              Text(
                'لقد أنهيت جميع الأسئلة',
                style: TextStyle(
                    fontFamily: 'MyriadArabic',
                    fontWeight: FontWeight.w400,
                    fontSize: 32),
              ),
              SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                'assets/svg/svgpic.svg',
                height: 100,
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
          buttons: [
            DialogButton(
              color: Color(0xff002767),
              onPressed: () {
                Navigator.pop(ctx);
                _replay();
              },
              child: Text(
                "أعد من جديد",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show().then((value) {
        _replay();
      });
    }
  }

  void _replay() {
    index = 0;
    sharedPreferences.setInt('savedIndex', index);
    notifyListeners();
  }

  void playSound(int i) {
    final player = AudioCache();
    if (i == 0) {
      player.play('correct.mp3');
    } else {
      player.play('wrong.mp3');
    }
  }

  void isCorrect(int pos) {
    bool ans = _db.getAt(index).answers[pos].isCorrect;
    if (ans) {
      playSound(0);
    } else {
      playSound(1);
    }
    for (int i = 0; i < buttonColor.length; i++) {
      if (i == pos) {
        if (ans) {
          buttonColor[i] = _TRUECOLOR;
        } else {
          buttonColor[i] = _FALSECOLOR;
        }
      } else {
        if (_db.getAt(index).answers[i].isCorrect) {
          buttonColor[i] = _TRUECOLOR;
        } else {
          buttonColor[i] = _FALSECOLOR;
        }
      }
    }
    Future.delayed(Duration(milliseconds: 2000)).then((value) {
      notifyListeners();
    });
    Future.delayed(Duration(milliseconds: 4500)).then((value) {
      nextQuestion();
      canClick = true;
    });
  }
}
