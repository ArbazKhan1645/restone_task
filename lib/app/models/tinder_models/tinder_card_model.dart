import 'package:flutter/material.dart';

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
