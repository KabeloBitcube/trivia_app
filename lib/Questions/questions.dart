import 'package:flutter/material.dart';
import 'package:trivia_app/Components/quizbutton.dart';
import 'package:trivia_app/Components/quizcontainer.dart';

class Questions extends StatelessWidget {
  Questions({super.key});

  final String quiz =
      "When Gmail first launched, how much storage did it provide for your email?";

  final List<String> options = ['512GB', '10GB', '5GB', 'Unlimited'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurpleAccent),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.deepPurpleAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Question 6', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 50),
            Stack(
              children: [
                Container(
                  height: 10,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 10,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            QuizContainer(quiz: quiz),
            const SizedBox(height: 50),
            // ListView.builder(
            //   itemCount: options.length,
            //   itemBuilder: (context, index) {
            //     return Column(
            //       children: [
            //         QuizButton(option: options[index])
            //       ],
            //     );
            //   },
            // )
            QuizButton(option: options[0]),
            SizedBox(height: 10,),
            QuizButton(option: options[1]),
            SizedBox(height: 10,),
            QuizButton(option: options[2]),
            SizedBox(height: 10,),
            QuizButton(option: options[3]),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
