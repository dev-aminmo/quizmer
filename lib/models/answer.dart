import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'answer.g.dart';

@HiveType(typeId: 0)
class Answer {
  @HiveField(0)
  final String answerText;
  @HiveField(1)
  final bool isCorrect;

  Answer({@required this.answerText, this.isCorrect = false});
}
