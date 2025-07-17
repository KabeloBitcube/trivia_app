import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:trivia_app/Components/quizbutton.dart';
import 'package:confetti/confetti.dart';

class ResultsScreen1 extends StatefulWidget {
  //score and totalScore variables to be passed into constructor
  final int score;
  final int totalScore;
  final ConfettiController controller;

  //constructor with required score and totalScore to store quiz results
  const ResultsScreen1({
    super.key,
    required this.score,
    required this.totalScore,
    required this.controller
  });

  @override
  State<ResultsScreen1> createState() => _ResultsScreen1State();
}

class _ResultsScreen1State extends State<ResultsScreen1> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        //Container height and width to fit the entire screen
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.deepPurpleAccent,
        child:
            Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConfettiWidget(confettiController: widget.controller),
                    //resultMessage function call to handle displaying result based on score
                    resultMessage(widget.score),
                    const SizedBox(height: 20),
                    //Stack to display done icon on two circular containers
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
                          top: 25,
                          left: 25,
                          child: SizedBox(
                            child: Icon(
                              Icons.done,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    //satrs function to handle displaying stars based on score
                    stars(widget.score),
                    const SizedBox(height: 50),
                    //Row to display the user's points
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You Earned',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${widget.score} pts',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 150),
                    //Button to replay quiz
                    QuizButton(text: 'Play Again'),
                  ],
                )
                .animate()
                .fadeIn(duration: 800.ms)
                .slideY(begin: 0.2, duration: 1200.ms, curve: Curves.easeOut), //Animated fade in from the bottom
      ),
    );
  }
}

//resultMessage function handling result message based on score
Widget resultMessage(int score) {
  if (score <= 40) {
    return Text(
      'You Can Do Better Next Time',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.white,
      ),
    );
  } else if (score >= 40 && score <= 80) {
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

//stars function handling the number of stars a user gets based on score
Widget stars(int score) {
  if (score == 0) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star),
        const SizedBox(width: 10),
        Icon(Icons.star, size: 50),
        const SizedBox(width: 10),
        Icon(Icons.star),
        const SizedBox(width: 10),
      ],
    );
  }
  if (score <= 40) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, color: Colors.yellow),
        const SizedBox(width: 10),
        Icon(Icons.star, size: 50),
        const SizedBox(width: 10),
        Icon(Icons.star),
        const SizedBox(width: 10),
      ],
    );
  } else if (score >= 40 && score <= 80) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, color: Colors.yellow),
        const SizedBox(width: 10),
        Icon(Icons.star, size: 50, color: Colors.yellow),
        const SizedBox(width: 10),
        Icon(Icons.star),
        const SizedBox(width: 10),
      ],
    );
  } else if (score == 100) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, color: Colors.yellow),
        const SizedBox(width: 10),
        Icon(Icons.star, size: 50, color: Colors.yellow),
        const SizedBox(width: 10),
        Icon(Icons.star, color: Colors.yellow),
        const SizedBox(width: 10),
      ],
    );
  } else {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star),
        const SizedBox(width: 10),
        Icon(Icons.star, size: 50),
        const SizedBox(width: 10),
        Icon(Icons.star),
        const SizedBox(width: 10),
      ],
    );
  }
}
