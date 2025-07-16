import 'package:flutter/material.dart';
import 'package:trivia_app/Home/home.dart';

//Re-usable quiz button that holds a text parameter to be display on the button
//Currently only used to navigate back to home
class QuizButton extends StatelessWidget {
  final String text;
  const QuizButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Trivia1HomePage()),
        );
      },
      child: Container(
        height: 50,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 24, 24, 24).withValues(alpha: 0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), 
            ),
          ],
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
