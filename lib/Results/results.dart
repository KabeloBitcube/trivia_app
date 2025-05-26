import 'package:flutter/material.dart';
import 'package:trivia_app/Components/quizbutton.dart';

class ResultsScreen extends StatelessWidget{
  final int score;
  final int totalScore;

  const ResultsScreen({super.key, required this.score, required this.totalScore});

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.done),
            const SizedBox(height: 20,),
            Text('Score: $score / $totalScore'),
            const SizedBox(height: 20,),
            QuizButton(text: 'Play Again',)
          ],
        ),
      ),
    );
  }
}