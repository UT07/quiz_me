import 'package:flutter/material.dart';
import './question.dart';

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

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionNumber = 0;
  List<Widget> scoreKeeper = [];
  List<Question> questions = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
  ];
  @override
  Widget build(BuildContext context) {
    return questionNumber < questions.length
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      questions.elementAt(questionNumber).questionText,
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
                      //The user picked true.
                      bool correctAnswer = questions[questionNumber].answer;
                      correctAnswer == true
                          ? scoreKeeper
                              .add(Icon(Icons.check, color: Colors.green))
                          : scoreKeeper
                              .add(Icon(Icons.close, color: Colors.red));
                      setState(() {
                        questionNumber++;

                        // scoreKeeper.add(
                        //   Icon(Icons.check, color: Colors.green),
                        // );
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade900),
                    ),
                    child: Text(
                      'False',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      bool correctAnswer = questions[questionNumber].answer;
                      correctAnswer == false
                          ? scoreKeeper
                              .add(Icon(Icons.check, color: Colors.green))
                          : scoreKeeper
                              .add(Icon(Icons.close, color: Colors.red));

                      setState(() {
                        questionNumber++;
                      });
                    },
                  ),
                ),
              ),
              Row(
                children: scoreKeeper,
              ),
            ],
          )
        : Text('Questions finished');
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.' , false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
