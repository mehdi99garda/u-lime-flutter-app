// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:u_lime/main.dart';

class ResultPage extends StatelessWidget {
  final String LQ1, LQ2;
  const ResultPage({Key? key, required this.LQ1, required this.LQ2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54B175),
        elevation: 0,
        title: const Text("Result"),
        centerTitle: true,
        toolbarHeight: 40,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/FullH.png',
              height: 70,
              fit: BoxFit.cover,
            ),
            const Text(
              "LQ1 and LQ2 are the quantities of limestone that you need to apply, However, you need to choose only one of them. To choose the adequate value, you need to take into consideration, the amount of (Ca2+ + Mg2+), the amount of (H + AL), and the price of limestone in your local market.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const Text(
                " N.B: a negative value means that no need to apply limestone",
                style: TextStyle(fontSize: 13)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "LQ1 : ",
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
                Text(
                  LQ1,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "LQ2 : ",
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
                Text(
                  LQ2,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
            const Text(
                "Disclaimer: This calculator is provided as a free service by Reda Mokere and El Mehdi El Garda. Calculator accuracy is not guaranteed. User assumes all risks and liabilities arising from its use.",
                textAlign: TextAlign.center),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                    (route) => false);
              },
              icon: const Icon(Icons.home_outlined),
              label: const Text("Back to home"),
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  primary: const Color(0xff54B175)),
            )
          ],
        ),
      ),
    );
  }
}
