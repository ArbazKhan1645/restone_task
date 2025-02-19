import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstone_task/app/models/tinder_models/tinder_card_model.dart';

class TinderController extends GetxController {
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
        title: 'Arbaz Khan',
        description: 'Explore the unknown',
        color: const Color(0xFFFF5F70),
      ),
      CardItem(
        id: '2',
        imageUrl: 'https://picsum.photos/400/601',
        title: 'Hammad Khan',
        description: 'City lights and vibes',
        color: const Color(0xFF2E9DFF),
      ),
      CardItem(
        id: '3',
        imageUrl: 'https://picsum.photos/400/602',
        title: 'Subhan Khan',
        description: 'Embrace the wilderness',
        color: const Color(0xFF8E44AD),
      ),
      CardItem(
        id: '4',
        imageUrl: 'https://picsum.photos/400/602',
        title: 'Qudrat Khan',
        description: 'Embrace the wilderness',
        color: const Color.fromARGB(255, 1, 80, 170),
      ),
    ];
  }

  void removeCard() {
    if (cards.isNotEmpty) {
      cards.removeAt(0);
      currentIndex.value = math.min(currentIndex.value + 1, cards.length - 1);
    }
  }
}
