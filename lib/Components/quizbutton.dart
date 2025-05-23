import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  final String option;
  const QuizButton({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white)
        ),
        child: Center(child: Text(option, style: TextStyle(color: Colors.white),)),
      ),
      );
  }
}
