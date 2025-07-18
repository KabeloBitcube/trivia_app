import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_app/Questions/questions.dart';
import 'package:trivia_app/flavors.dart';

class TriviaHomePage extends StatelessWidget {
  const TriviaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        //Container height and width to fit the entire screen
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.deepPurpleAccent,
        child: Column(
          children: [
            SizedBox(height: 40),
            //Column displaying figma images in rows
            //Question mark images stacked
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/Object2.png', width: 100),
                    SizedBox(width: 210),
                    Image.asset('assets/images/Object4.png', width: 100),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Stack(
                        children: [
                          Image.asset('assets/images/Object8.png', width: 100),
                          Image.asset(
                            'assets/images/Object5.png',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Image.asset('assets/images/Object10.png', width: 180),
                        Image.asset(
                          'assets/images/Object7.png',
                          width: 180,
                          height: 190,
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Image.asset('assets/images/Object9.png', width: 100),
                        Image.asset(
                          'assets/images/Object6.png',
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/Object3.png', width: 100),
                    SizedBox(width: 200),
                    Image.asset('assets/images/Object1.png', width: 100),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),
            //Container with button that starts quiz
            //Button stacked on container
            Padding(
              padding: const EdgeInsets.all(10),
              child: AvatarGlow(
                glowColor: Colors.grey,
                child: Stack(
                  clipBehavior: Clip.none, //So that the button is not clipped at the bottom
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(
                              255,
                              31,
                              30,
                              30,
                            ).withValues(alpha: 0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Press play to start',
                            style: GoogleFonts.pressStart2p(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            F.title,
                            style: GoogleFonts.pressStart2p(
                              color:Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Answer questions correctly to earn points',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 235,
                      left: 130,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            //Navigating to quiz
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Questions1(),
                              ),
                            );
                          },
                          child: Image.asset('assets/images/Play.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
