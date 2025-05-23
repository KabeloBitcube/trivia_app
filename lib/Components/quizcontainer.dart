import 'package:flutter/material.dart';

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
              color: Color.fromARGB(255, 56, 1, 66),
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
        ),
      ),
    );
  }
}
