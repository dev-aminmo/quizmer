import 'answer.dart';
import 'package:hive/hive.dart';
part 'question.g.dart';

@HiveType(typeId: 1)
class Question {
  @HiveField(0)
  final String questionText;
  @HiveField(1)
  final List<Answer> answers;

  Question(this.questionText, this.answers);
}
