import 'package:flutter/material.dart';


//Re-usable quiz container to display questions from API
class QuizContainer extends StatelessWidget {
  final String quiz;
  const QuizContainer({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            quiz,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
        ),
      ),
    );
  }
}
