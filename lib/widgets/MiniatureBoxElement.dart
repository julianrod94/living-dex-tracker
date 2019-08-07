import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';

class MiniatureBoxElement extends StatefulWidget {

  final Pokemon pokemon;
  final bool isShiny;
  final int livingdexId;
  final bool wasCaptured;

  MiniatureBoxElement({
    @required this.pokemon,
    @required this.isShiny,
    @required this.livingdexId,
    @required this.wasCaptured,
  });

  @override
  _MiniatureBoxElementState createState() => _MiniatureBoxElementState(wasCaptured);
}

class _MiniatureBoxElementState extends State<MiniatureBoxElement> {
  bool captured = false;

  _MiniatureBoxElementState(this.captured);


  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    return Container(
        //width: 20,
        //height: 20,
        //child: Card(
          color: this.captured ? Colors.amber : Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(widget.isShiny ? pokemon.shinySpriteUrl : pokemon.spriteUrl),
              ),
            ],
          ),
        //),
    );
  }
}