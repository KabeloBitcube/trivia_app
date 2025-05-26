import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:trivia_app/Components/quizcontainer.dart';
import 'package:http/http.dart' as http;
import 'package:trivia_app/Results/results.dart';

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
        'https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=multiple',
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ResultsScreen(score: score, totalScore: questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //API intergration
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.deepPurpleAccent),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.deepPurpleAccent,
          child: Center(child: CircularProgressIndicator(color: Colors.white)),
        ),
      );
    }

    Map<String, dynamic> currentQuestion = questions[currentIndex];
    String questionText = currentQuestion['question'];
    List<String> options = currentQuestion['options'];

    List<Widget> answerWidgets = [];

    for (var answer in options) {
      answerWidgets.add(
        GestureDetector(
          onTap: () {
            selectAnswer(answer);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                color: getAnswerColor(answer),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      24,
                      24,
                      24,
                    ).withValues(alpha: 0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(answer, style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
      );
    }

    List<Widget> columnChildren = [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.deepPurpleAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Question ${currentIndex + 1} of ${questions.length}',
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
                Positioned(child: progressBar(currentIndex)),
              ],
            ),
            const SizedBox(height: 50),
            QuizContainer(quiz: questionText),
            const SizedBox(height: 50),
            Column(children: answerWidgets),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                nextQuestion();
              },
              child: Text(
                currentIndex >= questions.length - 1 ? 'Finish' : 'Next',
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurpleAccent),
      body: SingleChildScrollView(child: Column(children: columnChildren)),
    );
  }
}

Widget progressBar(int index) {
  if (index == 0) {
    return Container(
      height: 10,
      width: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange,
      ),
    );
  } else if (index == 1) {
    return Container(
      height: 10,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange,
      ),
    );
  } else if (index == 2) {
    return Container(
      height: 10,
      width: 105,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange,
      ),
    );
  } else if (index == 3) {
    return Container(
      height: 10,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange,
      ),
    );
  } else if (index == 4) {
    return Container(
      height: 10,
      width: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange,
      ),
    );
  } else if (index == 5) {
    return Container(
      height: 10,
      width: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange,
      ),
    );
  } else if (index == 6) {
    return Container(
      height: 10,
      width: 245,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange,
      ),
    );
  } else if (index == 7) {
    return Container(
      height: 10,
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange,
      ),
    );
  } else if (index == 8) {
    return Container(
      height: 10,
      width: 315,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange,
      ),
    );
  } else if (index == 9) {
    return Container(
      height: 10,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange,
      ),
    );
  } else if (index == 10) {
    return Container(
      height: 10,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange,
      ),
    );
  }

  return Container(
    height: 10,
    width: 0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.deepOrange,
    ),
  );
}
