import 'package:flutter/material.dart';
import 'package:trivia_app/Components/quizbutton.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  final int totalScore;

  const ResultsScreen({
    super.key,
    required this.score,
    required this.totalScore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.deepPurpleAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            resultMessage(score),
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.11,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          255,
                          24,
                          24,
                          24,
                        ).withValues(alpha: 0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 18,
                  left: 20,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(
                            255,
                            24,
                            24,
                            24,
                          ).withValues(alpha: 0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 35,
                  left: 35,
                  child: SizedBox(
                    child: Icon(Icons.done, size: 30, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            stars(score),
            const SizedBox(height: 50),
            Text('Score: $score / $totalScore'),
            const SizedBox(height: 150),
            QuizButton(text: 'Play Again'),
          ],
        ),
      ),
    );
  }
}

Widget resultMessage(int score) {
  if (score <= 4) {
    return Text(
      'You Can Do Better Next Time',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.white,
      ),
    );
  } else if (score >= 4 && score <= 8) {
    return Text(
      'Nice Work',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.white,
      ),
    );
  } else {
    return Text(
      'Wow, You Are A Pro!',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.white,
      ),
    );
  }
}

Widget stars(int score) {
  if (score <= 4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, color: Colors.yellow,),
        const SizedBox(width: 10),
        Icon(Icons.star, size: 50),
        const SizedBox(width: 10),
        Icon(Icons.star),
        const SizedBox(width: 10),
      ],
    );
  }
  else if (score <= 8) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, color: Colors.yellow,),
        const SizedBox(width: 10),
        Icon(Icons.star, size: 50, color: Colors.yellow,),
        const SizedBox(width: 10),
        Icon(Icons.star),
        const SizedBox(width: 10),
      ],
    );
  }
  else if (score == 10) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, color: Colors.yellow,),
        const SizedBox(width: 10),
        Icon(Icons.star, size: 50, color: Colors.yellow,),
        const SizedBox(width: 10),
        Icon(Icons.star, color: Colors.yellow,),
        const SizedBox(width: 10),
      ],
    );
  }
  else{
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star,),
        const SizedBox(width: 10),
        Icon(Icons.star, size: 50),
        const SizedBox(width: 10),
        Icon(Icons.star),
        const SizedBox(width: 10),
      ],
    );
  }
}
