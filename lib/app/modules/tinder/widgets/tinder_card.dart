// card_stack_controller.dart
// animated_card_stack.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class CardStackController extends GetxController {
  RxList<CardItem> cards = <CardItem>[].obs;
  RxInt currentIndex = 0.obs;
  RxBool isAnimating = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSampleCards();
  }

  void loadSampleCards() {
    cards.value = [
      CardItem(
        id: '1',
        imageUrl: 'https://picsum.photos/400/600',
        title: 'Adventure Awaits',
        description: 'Explore the unknown',
        color: const Color(0xFFFF5F70),
      ),
      CardItem(
        id: '2',
        imageUrl: 'https://picsum.photos/400/601',
        title: 'Urban Discovery',
        description: 'City lights and vibes',
        color: const Color(0xFF2E9DFF),
      ),
      CardItem(
        id: '3',
        imageUrl: 'https://picsum.photos/400/602',
        title: 'Nature Calling',
        description: 'Embrace the wilderness',
        color: const Color(0xFF8E44AD),
      ),
      // Add more sample cards as needed
    ];
  }

  void removeCard() {
    if (cards.isNotEmpty) {
      cards.removeAt(0);
      currentIndex.value = math.min(currentIndex.value + 1, cards.length - 1);
    }
  }
}

class CardItem {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final Color color;

  CardItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.color,
  });
}

class AnimatedCardStack extends StatefulWidget {
  final CardStackController controller;

  const AnimatedCardStack({
    super.key,
    required this.controller,
  });

  @override
  State<AnimatedCardStack> createState() => _AnimatedCardStackState();
}

class _AnimatedCardStackState extends State<AnimatedCardStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _swipeController;
  late Animation<Offset> _swipeAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  Offset _dragStart = Offset.zero;
  Offset _currentDrag = Offset.zero;
  double _dragRotation = 0.0;

  @override
  void initState() {
    super.initState();
    _swipeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _swipeAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(2.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _swipeController,
      curve: Curves.easeOutCubic,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.4,
    ).animate(CurvedAnimation(
      parent: _swipeController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _swipeController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _swipeController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _dragStart = details.globalPosition;
    setState(() {
      _currentDrag = Offset.zero;
      _dragRotation = 0.0;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final dragDelta = details.globalPosition - _dragStart;
    setState(() {
      _currentDrag = dragDelta;
      _dragRotation = (dragDelta.dx / MediaQuery.of(context).size.width) * 0.4;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond;
    final speed = velocity.distance;

    if (speed > 1000 || _currentDrag.dx.abs() > 100) {
      final direction = _currentDrag.dx > 0 ? 1.0 : -1.0;
      _swipeAnimation = Tween<Offset>(
        begin: _currentDrag,
        end: Offset(direction * MediaQuery.of(context).size.width * 1.5, 0.0),
      ).animate(CurvedAnimation(
        parent: _swipeController,
        curve: Curves.easeOutCubic,
      ));

      _rotationAnimation = Tween<double>(
        begin: _dragRotation,
        end: direction * 0.4,
      ).animate(CurvedAnimation(
        parent: _swipeController,
        curve: Curves.easeOutCubic,
      ));

      _swipeController.forward().then((_) {
        widget.controller.removeCard();
        _swipeController.reset();
        setState(() {
          _currentDrag = Offset.zero;
          _dragRotation = 0.0;
        });
      });
    } else {
      // Spring back animation
      _swipeAnimation = Tween<Offset>(
        begin: _currentDrag,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _swipeController,
        curve: Curves.elasticOut,
      ));

      _rotationAnimation = Tween<double>(
        begin: _dragRotation,
        end: 0.0,
      ).animate(CurvedAnimation(
        parent: _swipeController,
        curve: Curves.elasticOut,
      ));

      _swipeController.forward().then((_) {
        _swipeController.reset();
        setState(() {
          _currentDrag = Offset.zero;
          _dragRotation = 0.0;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cards = widget.controller.cards;
      if (cards.isEmpty) {
        return const Center(
          child: Text(
            'No more cards!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }

      return Stack(
        alignment: Alignment.center,
        children: List.generate(math.min(3, cards.length), (index) {
          final card = cards[index];
          final isTopCard = index == 0;

          return Positioned(
            top: 0,
            child: AnimatedBuilder(
              animation: _swipeController,
              builder: (context, child) {
                double scale = 1.0 - (0.1 * index);
                if (!isTopCard) {
                  scale = scale + (_scaleAnimation.value * 0.1);
                }

                return Transform.translate(
                  offset: isTopCard
                      ? _currentDrag +
                          (_swipeAnimation.value * Offset.zero.distance)
                      : Offset(0, 20.0 * index),
                  child: Transform.rotate(
                    angle: isTopCard
                        ? _dragRotation + _rotationAnimation.value
                        : 0.0,
                    child: Transform.scale(
                      scale: scale,
                      child: child,
                    ),
                  ),
                );
              },
              child: GestureDetector(
                onPanStart: isTopCard ? _onPanStart : null,
                onPanUpdate: isTopCard ? _onPanUpdate : null,
                onPanEnd: isTopCard ? _onPanEnd : null,
                child: CardWidget(card: card),
              ),
            ),
          );
        }).reversed.toList(),
      );
    });
  }
}

class CardWidget extends StatelessWidget {
  final CardItem card;

  const CardWidget({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Placeholder for image (replace with actual image in production)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    card.color.withOpacity(0.8),
                    card.color,
                  ],
                ),
              ),
            ),
            // Content overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            // Card content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    card.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
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

class CardStackScreen extends StatelessWidget {
  CardStackScreen({super.key});

  final CardStackController controller = Get.put(CardStackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Swipeable Cards'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: AnimatedCardStack(
          controller: controller,
        ),
      ),
    );
  }
}
