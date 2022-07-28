import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GenderNotFound extends StatelessWidget {
  const GenderNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/wrong_anim2.json',
              width: 300,
            ),
            const Text('Tidak menemukan gender x _ x'),
          ],
        ),
      ),
    );
  }
}
