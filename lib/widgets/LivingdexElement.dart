import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:living_dex_tracker/data/Repository.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';

class LivingdexElement extends StatefulWidget {

  final Pokemon pokemon;
  final bool isShiny;
  final int livingdexId;
  final bool wasCaptured;

  LivingdexElement({
    @required this.pokemon,
    @required this.isShiny,
    @required this.livingdexId,
    @required this.wasCaptured,
  });

  @override
  _LivingdexElementState createState() => _LivingdexElementState(wasCaptured);
}

class _LivingdexElementState extends State<LivingdexElement> {
  bool captured = false;


  _LivingdexElementState(this.captured);

  void changeCaptureState() {
    captured ? Repository.get().releasePokemon(widget.livingdexId, widget.pokemon.id):
    Repository.get().capturePokemon(widget.livingdexId, widget.pokemon.id);
    setState(() {
      captured = !captured;
    });
  }

  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    return GestureDetector(
      onTap: changeCaptureState,
      child: Container(
        width: 60,
        height: 60,
        child: Card(
          color: this.captured ? Colors.amber : Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('${pokemon.name}'),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(widget.isShiny ? pokemon.shinySpriteUrl : pokemon.spriteUrl),
              ),
              Text('# ${zeroConversions(pokemon.nationalNumber)}'),
            ],
          ),
        ),
      ),
    );
  }
}

String zeroConversions(int pokenumber){
  if(pokenumber<10){
    return "00$pokenumber";
  }
  else if(pokenumber<100){
    return  "0$pokenumber";
  }
  else {
    return "$pokenumber";
  }
}