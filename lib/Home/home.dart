import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.deepPurpleAccent,
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/Object2.png', width: 100),
                      SizedBox(width: 200),
                      Image.asset('assets/images/Object4.png', width: 100),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/Object8.png',
                              width: 100,
                            ),
                            Image.asset('assets/images/Object5.png', width: 70),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Image.asset('assets/images/Object10.png', width: 180),
                          Image.asset('assets/images/Object7.png', width: 125,),
                        ],
                      ),
                      Stack(
                        children: [
                          Image.asset('assets/images/Object9.png', width: 100),
                          Image.asset('assets/images/Object6.png', width: 80),
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
            ),
          ],
        ),
      ),
    );
  }
}
