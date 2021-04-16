import 'package:assignment_03/models/models.dart';
import 'package:assignment_03/screens/planet_explorer/layouts/planet_explorer_narrow_layout.dart';
import 'package:assignment_03/screens/planet_explorer/layouts/planet_explorer_wide_layout.dart';
import 'package:flutter/material.dart';

class PlanetExplorer extends StatefulWidget {
  final List<Planet> planets;

  const PlanetExplorer({Key? key, required this.planets}) : super(key: key);

  @override
  _PlanetExplorerState createState() => _PlanetExplorerState();
}

class _PlanetExplorerState extends State<PlanetExplorer> {
  late Planet _planet;

  @override
  void initState() {
    _planet = widget.planets.first;

    super.initState();
  }

  Widget _buildPlanetTitle() => Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          _planet.name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      );

  Widget _buildPlanetImage() => ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          width: 200,
          height: 200,
          child: Image.network(
            _planet.imageUrl,
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress == null
                    ? child
                    : Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
            fit: BoxFit.cover,
          ),
        ),
      );

  List<Widget> _buildPlanetActions() => List.generate(
        widget.planets.length,
        (index) => SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: OutlinedButton(
            onPressed: () => setState(
              () => _planet = widget.planets[index],
            ),
            child: Text(widget.planets[index].name),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth <= 480
            ? PlanetExplorerNarrowLayout(
                title: _buildPlanetTitle(),
                image: _buildPlanetImage(),
                actions: _buildPlanetActions(),
              )
            : PlanetExplorerWideLayout(
                title: _buildPlanetTitle(),
                image: _buildPlanetImage(),
                actions: _buildPlanetActions(),
              ),
      );
}
