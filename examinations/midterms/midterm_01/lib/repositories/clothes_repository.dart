import 'package:midterm_01/models/models.dart';

class ClothesRepository {
  static List<Clothes> _clothing = [
    Clothes(
      id: 1,
      name: 'T-Shirt',
      imageUrl:
          'https://cdn.pixabay.com/photo/2017/01/13/04/56/blank-1976334_1280.png',
      size: 'M',
      price: 100.0,
      description: 'Nice T-Shirt for every day use',
    ),
    Clothes(
      id: 2,
      name: 'Jeans',
      imageUrl:
          'https://cdn.pixabay.com/photo/2020/03/02/12/13/jeans-4895576_1280.jpg',
      size: 'L',
      price: 99.9,
      description: 'Cool Jeans for the cool people',
    ),
    Clothes(
      id: 3,
      name: 'Jacket',
      imageUrl:
          'https://live.staticflickr.com/5582/14201538184_e74443161b_b.jpg',
      size: 'XS',
      price: 50.45,
      description: 'Fashion Jacket for people with taste',
    ),
    Clothes(
      id: 4,
      name: 'Sweater',
      imageUrl:
          'https://cdn.pixabay.com/photo/2019/08/27/05/04/ugly-sweater-4433379_1280.png',
      size: 'S',
      price: 30.0,
      description: 'Warm Sweater for the cold days',
    ),
    Clothes(
      id: 5,
      name: 'Trousers',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/9/93/Swiss_Army_gray_wool_blend_trousers_%2815367958348%29.jpg',
      size: 'M',
      price: 20.0,
      description: 'Nice pair of casual trousers',
    ),
    Clothes(
      id: 6,
      name: 'Coat',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/c/ca/Coat%2C_frock_%28AM_693379-4%29.jpg',
      size: 'XXL',
      price: 75.35,
      description: 'Very good Coat for everybody',
    ),
  ];

  static int id = _clothing.last.id + 1;

  void add(Clothes clothes) => _clothing.add(clothes);

  List<Clothes> fetch() => _clothing;

  void remove(int index) => _clothing.removeAt(index);

  void update(int index, Clothes clothes) => _clothing[index] = clothes;
}
