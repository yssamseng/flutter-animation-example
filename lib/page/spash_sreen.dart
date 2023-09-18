import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  double opacity = 1.0;

  void onEnd() {
    setState(() {
      opacity = 0.5;
    });
  }

  @override
  void initState() {
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   setState(() {
    //     opacity = 1.0;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Splash Screen'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // _buildLogoDefault(),
            _buildLogo(),
            _buildText(),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  _buildLogoDefault() {
    return Icon(
      Icons.android,
      size: 100,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  _buildLogo() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 30, end: 300),
      duration: const Duration(seconds: 2),
      curve: Curves.bounceOut,
      builder: (context, double value, child) {
        return Icon(
          Icons.android,
          size: value,
          color: Theme.of(context).colorScheme.primary,
        );
      },
      onEnd: onEnd,
    );
  }

  _buildText() {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(seconds: 1),
      child: Text(
        'Android Splash Screen',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
