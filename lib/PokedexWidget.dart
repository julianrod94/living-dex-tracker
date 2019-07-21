import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'PokeGridView.dart';

class PokedexWidget extends StatefulWidget {

  final String pokedexname;
  final String pokedexgame;
  final String pokedexspriteurl;

  PokedexWidget({
    @required this.pokedexname,
    @required this.pokedexgame,
    @required this.pokedexspriteurl
  });

  @override
  _PokedexWidgetState createState() => _PokedexWidgetState();
}

class _PokedexWidgetState extends State<PokedexWidget> {
  double pokedexcompletion = 0.0;

  Widget build(BuildContext context) {
    return Container(
/*        width: 60,
        height: 60,*/
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(widget.pokedexspriteurl),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('${widget.pokedexname}'),
              ),
              Text('${widget.pokedexgame}'),
            ],
          ),
      );
  }
}