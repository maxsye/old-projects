import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

/// './' means look in the same folder as the main dart file is,
/// and then the name of the file from which you want to import

//runApp is from material.dart

// void main()
// {
//   runApp(MyApp());
// }

void main() => runApp(
    MyApp()); //shorthand for functions that have only have one expression

//StatelessWidget, build, BuildContext, MaterialApp are from material.dart
class MyApp extends StatefulWidget {
  //will be recreated

  @override
  State<StatefulWidget> createState() {
    //this is a function
    return _MyAppState();
  }
}

///We create an object of class MyAppState in createState and MyAppState
///also knows about createState since it inherits (State<MyApp>)
///have this seperation so that MyAppState can be same and MyApp changes
///State<MyApp> means it belongs to MyApp
///We must tell flutter that if state is changed, re-render the widget
///Wrap the code that changes and needs to be rendered in setState()
///setState() re-renders by calling build() of the class that contains setState()
///which is class MyAppState in this case
///leading underscore turns public into private
class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'What do you do at parties?',
      'answers': [
        {'text': 'Bring food', 'score': 3},
        {'text': 'Dab on everyone', 'score': 1},
        {'text': 'Poop on the floor', 'score': 0},
        {'text': 'Act like a normal person', 'score': 2},
      ],
    },
    {
      'questionText': 'What\'s your favorite food?',
      'answers': [
        {'text': 'Bacon', 'score': 3},
        {'text': 'Cake', 'score': 2},
        {'text': 'Toothpaste', 'score': 1},
        {'text': 'Mouse', 'score': 0},
      ],
    },
    {
      'questionText': 'How much do you like the quiz from 1-5?',
      'answers': [
        {'text': '1', 'score': 0},
        {'text': '2', 'score': 1},
        {'text': '3', 'score': 2},
        {'text': '4', 'score': 3},
        {'text': '5', 'score': 4},
      ],
    },
    {
      'questionText': 'Is Ray stupid?',
      'answers': [
        {'text': 'Yes, and Max is much smarter', 'score': 3},
        {'text': 'Yes', 'score': 2},
        {'text': 'Maybe', 'score': 1},
        {'text': 'No', 'score': 0},
      ],
    }
  ];
  //will not be recreated

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
        _questionIndex = 0;
        _totalScore = 0;
      },
    );
  }

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      //tells Flutter to change the state when questionIndex changes
      _questionIndex = _questionIndex + 1;
    });
  }

  @override //Calls a declarator, make code clearer and cleaner
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('My First App'),
          ), //always add comma after closing parentheses
          //'?' means if true
          //if _questionIndex < questions.length is true Column(children: )...
          //':' in this case means else
          body: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questions: _questions,
                  questionIndex: _questionIndex,
                )
              : Result(_totalScore, _resetQuiz)),
    );
  }
}

///good convention: one widget per file
