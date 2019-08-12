import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';
import 'package:living_dex_tracker/data/Repository.dart';

class MiniatureBoxElement extends StatefulWidget {

  final Pokemon pokemon;
  final bool isShiny;
  final int livingdexId;
  final bool wasCaptured;
  final onCaptureStatusChange;

  MiniatureBoxElement({
    @required this.pokemon,
    @required this.isShiny,
    @required this.livingdexId,
    @required this.wasCaptured,
    @required this.onCaptureStatusChange,
  });

  @override
  _MiniatureBoxElementState createState() => _MiniatureBoxElementState(wasCaptured);
}

class _MiniatureBoxElementState extends State<MiniatureBoxElement> {
  bool captured = false;

  _MiniatureBoxElementState(this.captured);

  void changeCaptureState() {
    captured ?
    Repository.get().releasePokemon(widget.livingdexId, widget.pokemon.id):
    Repository.get().capturePokemon(widget.livingdexId, widget.pokemon.id);

    setState(() {
      captured = !captured;
    });

    widget.onCaptureStatusChange(captured);
  }

  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    return GestureDetector(
      onTap: changeCaptureState,
      child: Container(
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
      ),
    );
  }
}