import 'package:flutter/material.dart';
import 'package:midterm_01/models/models.dart';
import 'package:midterm_01/repositories/repositories.dart';

class ClothesDetailsScreen extends StatelessWidget {
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments
        as ClothesDetailsScreenArguments;

    final index = arguments.index;
    final clothes = arguments.clothes;

    return Scaffold(
      appBar: AppBar(
        title: Text('Clothes Details'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Remove Clothes'),
                content: Text('Would you like to remove the clothes?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final clothesRepository = ClothesRepository();

                      clothesRepository.remove(index);

                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Remove'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/clothes_placeholder.png',
                image: clothes.imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 1.5,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: '),
                    Text('Price: '),
                    Text('Size: '),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clothes.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      clothes.price.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      clothes.size,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Text(
                        clothes.description,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
