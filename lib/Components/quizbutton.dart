import 'package:flutter/material.dart';
import 'package:trivia_app/Home/home.dart';

class QuizButton extends StatelessWidget {
  final String text;
  const QuizButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        );
      },
      child: Container(
        height: 50,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
