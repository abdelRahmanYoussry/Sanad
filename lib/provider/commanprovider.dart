import 'package:flutter/material.dart';

class CommanProvider extends ChangeNotifier {
  int? selectAnswer = -1;
  int correctanswer = 0;
  int inCorrectanswer = 0;
  double correctPercent = 0.0;

  answerclick(int pos) {
    selectAnswer = pos;
    notifyListeners();
  }

  correctAnswer(int pos, int totalQ) {
    if (pos == 1) {
      correctanswer++;
    } else {
      correctanswer = 0;
    }
    correctPercent = (correctanswer * totalQ) / 100;
    print(correctPercent);
    notifyListeners();
  }

  inCorrectAnswer(int pos, int totalQ) {
    inCorrectanswer++;
    if (pos == 1) {
      inCorrectanswer++;
    } else {
      inCorrectanswer = 0;
    }
    notifyListeners();
  }
}
