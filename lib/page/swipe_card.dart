import 'package:flutter/material.dart';

class SwipeCard extends StatefulWidget {
  const SwipeCard({super.key});

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  late PageController _pageController;
  int _currentPage = 0;

  void onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.7);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Swipe Card'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // _buildPageView(),
          _buildPageViewTweenAnimation(),
          const SizedBox(height: 16),
          _buildIndicatorView(),
        ],
      ),
    );
  }

  _buildPageViewTweenAnimation() {
    return Container(
      height: 260,
      color: Theme.of(context).colorScheme.background,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 5,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          var _scale = _currentPage == index ? 1.0 : 0.8;
          // return Transform.scale(
          //   scale: _scale,
          //   child: _buildCard(index),
          // );
          return TweenAnimationBuilder(
            tween: Tween<double>(begin: _scale, end: _scale),
            duration: const Duration(milliseconds: 350),
            curve: Curves.linear,
            child: _buildCard(index),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
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
      margin: const EdgeInsets.only(bottom: 48, top: 24),
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
