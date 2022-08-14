import 'package:flutter/material.dart';

class CommanProvider extends ChangeNotifier {
  int? selectAnswer = -1;
  int correctanswer = 0;
  int inCorrectanswer = 0;
  int correctAns = -1;
  double correctPercent = 0.0;
  double incorrectPercent = 0.0;

  answerclick(int pos) {
    selectAnswer = pos;
    notifyListeners();
  }

  correctAnswer(int pos, int totalQ, int corAns) {
    if (pos == 1) {
      correctanswer++;
    } else {
      correctanswer = 0;
    }
    correctPercent = (correctanswer * 100) / totalQ;
    notifyListeners();
  }

  inCorrectAnswer(int pos, int totalQ, int corAns) {
    if (pos == 1) {
      inCorrectanswer++;
    } else {
      inCorrectanswer = 0;
    }
    incorrectPercent = (inCorrectanswer * 100) / totalQ;
    notifyListeners();
  }

  corAns(int corAns) {
    correctAns = corAns;
  }
}
