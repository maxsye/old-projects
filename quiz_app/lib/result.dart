import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final Function reset;

  Result(this.totalScore, this.reset);

  String get resultPhrase {
    if (totalScore >= 11) {
      return 'You are a very nice person';
    } else if (totalScore >= 7) {
      return 'You aren\'t bad as a person';
    } else {
      return 'You are an odd and weird person';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text(
              'Restart quiz',
            ),
            textColor: Colors.blue,
            onPressed: reset,
          ),
        ],
      ),
    );
  }
}
