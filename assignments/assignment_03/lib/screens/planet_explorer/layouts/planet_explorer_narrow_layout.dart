import 'package:flutter/material.dart';

class PlanetExplorerNarrowLayout extends StatefulWidget {
  final Widget title;
  final Widget image;
  final List<Widget> actions;

  const PlanetExplorerNarrowLayout({
    Key? key,
    required this.title,
    required this.image,
    required this.actions,
  });

  @override
  _PlanetExplorerNarrowLayoutState createState() =>
      _PlanetExplorerNarrowLayoutState();
}

class _PlanetExplorerNarrowLayoutState
    extends State<PlanetExplorerNarrowLayout> {
  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              widget.title,
              widget.image,
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.actions,
            ),
          ),
        ],
      );
}
