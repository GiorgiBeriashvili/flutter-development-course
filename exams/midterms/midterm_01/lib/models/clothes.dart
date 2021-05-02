class Clothes {
  final int id;
  final String name;
  final String imageUrl;
  final String size;
  final double price;
  final String description;

  const Clothes({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.size,
    required this.price,
    required this.description,
  });
}

class ClothesDetailsScreenArguments {
  final int index;
  final Clothes clothes;

  const ClothesDetailsScreenArguments({
    required this.index,
    required this.clothes,
  });
}

class ClothesEditScreenArguments {
  final int index;
  final Clothes clothes;

  const ClothesEditScreenArguments({
    required this.index,
    required this.clothes,
  });
}
