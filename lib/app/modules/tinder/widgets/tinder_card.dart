// card_stack_controller.dart
// animated_card_stack.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstone_task/app/modules/animated_chart/views/animated_chart_view.dart';
import 'dart:math' as math;
import 'package:redstone_task/app/modules/tinder/controllers/tinder_controller.dart';
import 'package:redstone_task/app/modules/tinder/widgets/card_widget.dart';

class AnimatedCardStack extends StatefulWidget {
  final TinderController controller;

  const AnimatedCardStack({super.key, required this.controller});

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
  bool _isRemovingCard = false;

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
    ).animate(
      CurvedAnimation(parent: _swipeController, curve: Curves.easeOutCubic),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
      CurvedAnimation(parent: _swipeController, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _swipeController, curve: Curves.easeOutCubic),
    );

    _swipeController.addStatusListener(_handleAnimationStatus);
  }

  @override
  void dispose() {
    _swipeController.removeStatusListener(_handleAnimationStatus);
    _swipeController.dispose();
    super.dispose();
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (_isRemovingCard) {
        widget.controller.removeCard();
        _isRemovingCard = false;
      }
      _swipeController.reset();
      setState(() {
        _currentDrag = Offset.zero;
        _dragRotation = 0.0;
      });
    }
  }

  void _onPanStart(DragStartDetails details) {
    _dragStart = details.globalPosition;
    setState(() {
      _currentDrag = Offset.zero;
      _dragRotation = 0.0;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_isRemovingCard) return;
    final dragDelta = details.globalPosition - _dragStart;
    setState(() {
      _currentDrag = dragDelta;
      _dragRotation = (dragDelta.dx / MediaQuery.of(context).size.width) * 0.4;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_isRemovingCard) return;

    final velocity = details.velocity.pixelsPerSecond;
    final speed = velocity.distance;

    if (speed > 1000 || _currentDrag.dx.abs() > 100) {
      _isRemovingCard = true;
      final direction = _currentDrag.dx > 0 ? 1.0 : -1.0;

      _swipeAnimation = Tween<Offset>(
        begin: _currentDrag,
        end: Offset(direction * MediaQuery.of(context).size.width * 1.5, 0.0),
      ).animate(
        CurvedAnimation(parent: _swipeController, curve: Curves.easeOutCubic),
      );

      _rotationAnimation = Tween<double>(
        begin: _dragRotation,
        end: direction * 0.4,
      ).animate(
        CurvedAnimation(parent: _swipeController, curve: Curves.easeOutCubic),
      );

      _swipeController.forward();
    } else {
      _swipeAnimation = Tween<Offset>(
        begin: _currentDrag,
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: _swipeController, curve: Curves.elasticOut),
      );

      _rotationAnimation = Tween<double>(
        begin: _dragRotation,
        end: 0.0,
      ).animate(
        CurvedAnimation(parent: _swipeController, curve: Curves.elasticOut),
      );

      _swipeController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cards = widget.controller.cards;
      if (cards.isEmpty) {
        return Center(child: AnimatedChartView());
      }

      return Stack(
        alignment: Alignment.center,
        children:
            List.generate(math.min(3, cards.length), (index) {
              final card = cards[index];
              final isTopCard = index == 0;

              return Positioned(
                top: 20,
                child: AnimatedBuilder(
                  animation: _swipeController,
                  builder: (context, child) {
                    double scale = 1.0 - (0.1 * index);
                    if (!isTopCard) {
                      scale = scale + (_scaleAnimation.value * 0.1);
                    }

                    final offset =
                        isTopCard
                            ? _currentDrag +
                                (_swipeAnimation.value *
                                    (_isRemovingCard ? 1.0 : 0.0))
                            : Offset(0, 20.0 * index);

                    final rotation =
                        isTopCard
                            ? _dragRotation +
                                (_rotationAnimation.value *
                                    (_isRemovingCard ? 1.0 : 0.0))
                            : 0.0;

                    return Transform.translate(
                      offset: offset,
                      child: Transform.rotate(
                        angle: rotation,
                        child: Transform.scale(scale: scale, child: child),
                      ),
                    );
                  },
                  child: GestureDetector(
                    onPanStart:
                        isTopCard && !_isRemovingCard ? _onPanStart : null,
                    onPanUpdate:
                        isTopCard && !_isRemovingCard ? _onPanUpdate : null,
                    onPanEnd: isTopCard && !_isRemovingCard ? _onPanEnd : null,
                    child: CardWidget(card: card),
                  ),
                ),
              );
            }).reversed.toList(),
      );
    });
  }
}
