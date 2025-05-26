import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:trivia_app/Components/quizbutton.dart';
import 'package:trivia_app/Components/quizcontainer.dart';
import 'package:http/http.dart' as http;

class Questions extends StatefulWidget {
  Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  //For testing layout
  final String quiz =
      "When Gmail first launched, how much storage did it provide for your email?";

  final List<String> options = ['512GB', '10GB', '5GB', 'Unlimited'];

  //API integration
  List<Map<String, dynamic>> questions = [];
  int currentIndex = 0;
  int score = 0;
  String? selectedAnswer;
  bool showNext = false;
  final unescape = HtmlUnescape();

  @override
  void initState() {
    super.initState();
    fetchQuiz();
  }

  Future<void> fetchQuiz() async {
    final response = await http.get(
      Uri.parse(
        'https://opentdb.com/api.php?amount=10&category=9&difficulty=easy',
      ),
      headers: {'Content-Type': 'application/json'},
    );

    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['results'] != null && data['results'].isNotEmpty) {
        List<Map<String, dynamic>> loadedQuestions = [];

        for (var item in data['results']) {
          String questionText = unescape.convert(item['question']);
          String correctAnswer = unescape.convert(item['correct_answer']);
          List<String> options = List<String>.from(
            item['incorrect_answers'].map(
              (e) => unescape.convert(e.toString()),
            ),
          );

          options.add(correctAnswer);
          options.shuffle();

          loadedQuestions.add({
            'question': questionText,
            'correct_answer': correctAnswer,
            'options': options,
          });

          if (!mounted) return;

          setState(() {
            questions = loadedQuestions;
            currentIndex = 0;
            score = 0;
            selectedAnswer = null;
            showNext = false;
          });
        }
      }
    } else {
      log('Failed to load API. Response status: ${response.statusCode}');
    }
  }

  void selectAnswer(String answer) {
    if (selectedAnswer != null) return;

    bool isCorrect = answer == questions[currentIndex]['correct_answer'];
    if (isCorrect) {
      score++;
    }

    setState(() {
      selectedAnswer = answer;
      showNext = true;
    });
  }

  Color getAnswerColor(String answer) {
    if (selectedAnswer == null) {
      return Colors.deepOrange;
    }
    if (answer == questions[currentIndex]['correct_answer']) {
      return Colors.lightBlue;
    }
    if (answer == selectedAnswer) {
      return Colors.red;
    }

    return Colors.deepOrange;
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedAnswer = null;
        showNext = false;
      });
    } else {
      //Navigate to final results
    }
  }

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
            const Text(
              'Question 6',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            SizedBox(height: 10),
            QuizButton(option: options[1]),
            SizedBox(height: 10),
            QuizButton(option: options[2]),
            SizedBox(height: 10),
            QuizButton(option: options[3]),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
