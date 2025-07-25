import 'dart:convert';
import 'dart:developer';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:trivia_app/Components/quizcontainer.dart';
import 'package:http/http.dart' as http;
import 'package:trivia_app/Results/results.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  //API integration > variables to store API data and track user activity
  List<Map<String, dynamic>> questions = [];
  int currentIndex = 0;
  int score = 0;
  String? selectedAnswer;
  final unescape =
      HtmlUnescape(); //To convert html escape sequences from API to original characters

  //Call fetchQuiz
  @override
  void initState() {
    super.initState();
    fetchQuiz();
  }

  final controller = ConfettiController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  //fectQuiz function to handle API requests
  Future<void> fetchQuiz() async {
    final response = await http.get(
      Uri.parse(
        'https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=multiple',
      ),
      headers: {'Content-Type': 'application/json'},
    );

    //Logging responses
    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); //Decode response body

      //Checking that results are not null or empty
      if (data['results'] != null && data['results'].isNotEmpty) {
        List<Map<String, dynamic>> loadedQuestions = []; //List to store results

        //Convert data using html unescape
        for (var item in data['results']) {
          String questionText = unescape.convert(item['question']);
          String correctAnswer = unescape.convert(item['correct_answer']);
          List<String> options = List<String>.from(
            item['incorrect_answers'].map(
              (e) => unescape.convert(e.toString()),
            ),
          );

          //Add correct answer to options list and shuffle the options
          options.add(correctAnswer);
          options.shuffle();

          //Add results from API to loadedQuestions list
          loadedQuestions.add({
            'question': questionText,
            'correct_answer': correctAnswer,
            'options': options,
          });

          //Checks if widget is still in widget tree
          if (!mounted) return;

          //Updating the state
          setState(() {
            questions = loadedQuestions;
            currentIndex = 0;
            score = 0;
            selectedAnswer = null;
          });
        }
      }
    } else {
      //Logging failed API call with its status code
      log('Failed to load API. Response status: ${response.statusCode}');
    }
  }

  //selectAnswer function that handles the user's selection
  void selectAnswer(String answer) {
    if (selectedAnswer != null) return; //Prevent re-selection

    //Checks if answer is correct and increments by 10 if true
    bool isCorrect = answer == questions[currentIndex]['correct_answer'];
    if (isCorrect) {
      score += 10;
    }

    //Update state after user makes a selection
    setState(() {
      selectedAnswer = answer;
    });

    //Automatically transitions to the next next question after selection
    Future.delayed(const Duration(seconds: 2), () {
      if (currentIndex < questions.length - 1) {
        setState(() {
          currentIndex++;
          selectedAnswer = null;
        });
      } else {
        //Navigate to final results
        //Pass score and question length values to the results screen

        //NB: Not sure how to solve context warning
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                ResultsScreen(score: score, totalScore: questions.length, controller: controller,),
          ),
        );

        controller.play();
      }
    });
  }

  //getAnswerColor function to set button colour based on the answer
  Color getAnswerColor(String answer) {
    if (selectedAnswer == null) {
      return Theme.of(context).primaryColor;
    }
    //Always shows correct answer after selection - it iterates through the API options so will always find the correct answer
    //But show only correct answer if user selects correctly
    if (answer == questions[currentIndex]['correct_answer']) {
      return Colors.green;
    }
    //Only appears after incorrect selection
    if (answer == selectedAnswer) {
      return Colors.red;
    }

     //Set color of unselected options to transparent when the user makes a selection
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    //API intergration > displaying and manipulating data from API
    //If questions are empty display a loading indicator
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color:Theme.of(context).scaffoldBackgroundColor,
          child: Center(child: CircularProgressIndicator(color: Colors.white)),
        ),
      );
    }

    //Variables to store and display the current question and answer options
    Map<String, dynamic> currentQuestion = questions[currentIndex];
    String questionText = currentQuestion['question'];
    List<String> options = currentQuestion['options'];

    //Variable to store list of options
    List<Widget> answerWidgets = [];

    //Iterate through API answer options
    //Display options in a container
    for (var answer in options) {
      answerWidgets.add(
        GestureDetector(
              onTap: () {
                //Handles answer selection
                selectAnswer(answer);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    color: getAnswerColor(answer), //Handle container colors
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
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(answer, style: TextStyle(color: Colors.white)), //Display option from API
                  ),
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms)
            .slideX(begin: 0.2, duration: 1200.ms, curve: Curves.easeOut), //Animated fade in from the right for the quiz options
      );
    }

    //Column to display quiz layout - question index, progress bar,
    //container with question (re-usbale quiz container) and the answerWidgets
    List<Widget> columnChildren = [
      SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                Positioned(child: progressBar(currentIndex, context)), //Question progress bar
              ],
            ),
            const SizedBox(height: 50),
            //Animated fade in from the right for the quiz container
            QuizContainer(quiz: questionText).animate()
            .fadeIn(duration: 800.ms)
            .slideX(begin: 0.2, duration: 1200.ms, curve: Curves.easeOut),
            const SizedBox(height: 50),
            Column(children: answerWidgets), //answerWidgets added to the list of column children
            const SizedBox(height: 50),
          ],
        ),
      )
    ];

    //Return the columnChildren list
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: SingleChildScrollView(child: Column(children: columnChildren)),
    );
  }
}

//progressBar function to increase question progress bar as user goes through more questions
Widget progressBar(int index, BuildContext context) {
  if (index == 0) {
    return Container(
      height: 10,
      width: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
    );
  } else if (index == 1) {
    return Container(
      height: 10,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
    );
  } else if (index == 2) {
    return Container(
      height: 10,
      width: 105,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
    );
  } else if (index == 3) {
    return Container(
      height: 10,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
    );
  } else if (index == 4) {
    return Container(
      height: 10,
      width: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
    );
  } else if (index == 5) {
    return Container(
      height: 10,
      width: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
    );
  } else if (index == 6) {
    return Container(
      height: 10,
      width: 245,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
    );
  } else if (index == 7) {
    return Container(
      height: 10,
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
    );
  } else if (index == 8) {
    return Container(
      height: 10,
      width: 315,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
    );
  } else if (index == 9) {
    return Container(
      height: 10,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
    );
  } else if (index == 10) {
    return Container(
      height: 10,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  return Container(
    height: 10,
    width: 0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).primaryColor,
    ),
  );
}
