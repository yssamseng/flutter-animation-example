import 'package:flutter/material.dart';

class SwipeAdvanceAnimation extends StatefulWidget {
  const SwipeAdvanceAnimation({super.key});

  @override
  State<SwipeAdvanceAnimation> createState() => _SwipeAdvanceAnimationState();
}

class _SwipeAdvanceAnimationState extends State<SwipeAdvanceAnimation> {
  late PageController _pageController;
  double _currentPage = 0;

  final double _scaleFactor = 0.8;
  final double _height = 260;

  void onPageChanged(int index) {
    setState(() {
      // _currentPage = index;
    });
  }

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
        print(_currentPage);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Swipe Advance Animation'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // _buildPageView(),
          _buildPageViewAdvancedAnimation(),
          const SizedBox(height: 16),
          _buildIndicatorView(),
        ],
      ),
    );
  }

  _buildPageViewAdvancedAnimation() {
    return Container(
      height: 260,
      color: Theme.of(context).colorScheme.background,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 5,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          Matrix4 matrix = Matrix4.identity();
          if (index == _currentPage.floor()) {
            var currentScale = 1.0 - (_currentPage - index) * (1.0 - _scaleFactor);
            var currentTranslation = _height * (1.0 - currentScale) / 2;
            matrix = Matrix4.diagonal3Values(1.0, currentScale, 1.0)
            ..setTranslationRaw(0.0, currentTranslation, 0.0);
          } else if (index == _currentPage.floor() + 1) {
            var currentScale = _scaleFactor + (_currentPage - index + 1) * (1.0 - _scaleFactor);
            var currentTranslation = _height * (1.0 - currentScale) / 2;
            matrix = Matrix4.diagonal3Values(1.0, currentScale, 1.0)
            ..setTranslationRaw(0.0, currentTranslation, 0.0);
          } else if (index == _currentPage.floor() - 1) {
            var currentScale = 1.0 - (_currentPage - index) * (1.0 - _scaleFactor);
            var currentTranslation = _height * (1.0 - currentScale) / 2;
            matrix = Matrix4.diagonal3Values(1.0, currentScale, 1.0)
            ..setTranslationRaw(0.0, currentTranslation, 0.0);
          } else {
            var currentScale = 0.8;
            var currentTranslation = _height * (1.0 - currentScale) / 2;
            matrix = Matrix4.diagonal3Values(1.0, currentScale, 1.0)
            ..setTranslationRaw(0, currentTranslation, 0);
          }
          return Transform(
            transform: matrix,
            child: _buildCard(index),
          );
        },
      ),
    );
  }

  _buildPageView() {
    return Container(
      height: 260,
      color: Theme.of(context).colorScheme.background,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 5,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          return _buildCard(index);
        },
      ),
    );
  }

  _buildCard(int index) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _buildCardTop(),
        _buildCardBottom(index),
      ],
    );
  }

  _buildCardTop() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 48, top: 24, left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(113, 0, 0, 0),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
        color: Theme.of(context).colorScheme.secondary,
      ),
      // child: const Center(
      //   child: Text(
      //     // 'Card ${index + 1}',
      //     '',
      //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //   ),
      // ),
    );
  }

  _buildCardBottom(int index) {
    return Positioned(
      bottom: 24,
      child: Container(
        width: 188,
        height: 68,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(113, 0, 0, 0),
              blurRadius: 16,
            ),
          ],
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        child: Center(
          child: Text(
            'Card ${index + 1}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // indicator
  _buildIndicatorView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(5, (index) => Indicator(isActive: index == _currentPage)),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Indicator({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 22 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
