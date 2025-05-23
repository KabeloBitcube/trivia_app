import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage ({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.deepPurpleAccent,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/Object8.png', width: 100,),
                      Image.asset('assets/images/Object10.png'),
                      Image.asset('assets/images/Object9.png', width: 100,)
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