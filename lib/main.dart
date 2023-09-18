import 'package:flutter/material.dart';
import 'package:swipecard_animation/page/spash_sreen.dart';
import 'package:swipecard_animation/page/swipe_advance_animation.dart';
import 'package:swipecard_animation/page/swipe_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'This is demo app with',
              style: TextStyle(fontSize: 14),
            ),
            const Text(
              'TweenAnimationBuilder',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 16),
            _buildButtonSplashScreen(),
            const SizedBox(height: 4),
            _buildButtonSwipeCard(),
            const SizedBox(height: 16),
            const Text(
              'PageView Advance Animation',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            _buildButtonSwipeAdvanceAnimation(),
          ],
        ),
      ),
    );
  }

  // button to SwipeCard page
  _buildButtonSwipeCard() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SwipeCard(),
          ),
        );
      },
      child: const Text('Swipe Card'),
    );
  }

  // button to SplashScreen page
  _buildButtonSplashScreen() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          ),
        );
      },
      child: const Text('Splash Screen'),
    );
  }

  //SwipeAdvanceAnimation
  _buildButtonSwipeAdvanceAnimation() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SwipeAdvanceAnimation(),
          ),
        );
      },
      child: const Text('Swipe Advance Animation'),
    );
  }
}
