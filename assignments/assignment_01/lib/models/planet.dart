import 'package:flutter/foundation.dart';

class Planet {
  final String name;
  final String imageUrl;
  final String description;

  const Planet({
    @required this.name,
    @required this.imageUrl,
    @required this.description,
  });
}
