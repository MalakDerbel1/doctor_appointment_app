import 'package:DocEase/utils/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: LottieBuilder.asset(
                  'assets/DOCTOR.json',
                ),
              ),
              customTextWidget(
                  text: "MEDCONNECT",
                  color: Colors.blue,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  lineHeight: 1,
                  maxLines: 10)
            ],
          ),
        ),
      ),
    );
  }
}
