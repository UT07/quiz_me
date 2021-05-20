import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './quizData.dart';

void main() => runApp(QuizMe());

class QuizMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

QuizData quizData = new QuizData();

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  int questionNumber = quizData.getQuestionNumber();
  int quizLength = quizData.questionsLength();
  void checkAnswer(bool userSelectedAnswer) {
    bool correctAnswer = quizData.getCorrectAnswer();
    setState(() {
      if (quizData.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!!',
          desc: 'You\'ve reached the end of the quiz.',
          style: AlertStyle(
            backgroundColor: Colors.grey.shade900,
            titleStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            descStyle: TextStyle(color: Colors.white),
          ),
        ).show();
        quizData.reset();
        scoreKeeper = [];
      } else {
        correctAnswer == userSelectedAnswer
            ? scoreKeeper.add(
                Icon(Icons.check, color: Colors.green),
              )
            : scoreKeeper.add(
                Icon(Icons.close, color: Colors.red),
              );
        quizData.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizData.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.green.shade900),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red.shade900),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
