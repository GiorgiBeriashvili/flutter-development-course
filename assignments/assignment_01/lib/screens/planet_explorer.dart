import 'package:assignment_01/models/models.dart';
import 'package:flutter/material.dart';

class PlanetExplorer extends StatefulWidget {
  final List<Planet> planets;

  const PlanetExplorer({Key key, @required this.planets}) : super(key: key);

  @override
  _PlanetExplorerState createState() => _PlanetExplorerState();
}

class _PlanetExplorerState extends State<PlanetExplorer> {
  Planet _planet;

  @override
  void initState() {
    _planet = widget.planets.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  _planet.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  width: 250,
                  height: 250,
                  child: Image.network(
                    _planet.imageUrl,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.planets.length,
              (index) => SizedBox(
                width: 90.0,
                child: OutlinedButton(
                  onPressed: () => setState(
                    () => _planet = widget.planets[index],
                  ),
                  child: Text(widget.planets[index].name),
                ),
              ),
            ),
          ),
        ],
      );
}
