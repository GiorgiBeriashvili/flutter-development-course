import 'package:flutter/material.dart';

class PlanetExplorerWideLayout extends StatefulWidget {
  final Widget title;
  final Widget image;
  final List<Widget> actions;

  const PlanetExplorerWideLayout({
    Key? key,
    required this.title,
    required this.image,
    required this.actions,
  });

  @override
  _PlanetExplorerWideLayoutState createState() =>
      _PlanetExplorerWideLayoutState();
}

class _PlanetExplorerWideLayoutState extends State<PlanetExplorerWideLayout> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  widget.image,
                  widget.title,
                ],
              ),
              Column(
                children: widget.actions,
              ),
            ],
          ),
        ),
      );
}
