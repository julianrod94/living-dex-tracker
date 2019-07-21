import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LivingdexListElement extends StatefulWidget {
  final String name;
  final String type;
  final String game;
  final int totalPokemon;

  LivingdexListElement({
    @required this.name,
    @required this.type,
    @required this.game,
    @required this.totalPokemon
  });

  @override
  _LivingdexListElementState createState() => _LivingdexListElementState();

}

class _LivingdexListElementState extends State<LivingdexListElement> {
  int capturedPokemon = 0;


  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                      '${widget.name}',
                        textAlign: TextAlign.start,
                        textScaleFactor: 1.5,
                        style: TextStyle(fontWeight: FontWeight.bold)
                ),
                    )),
                Container(
                  color: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10),
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                      borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Text('${widget.type}'),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10),
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                      borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Text('${widget.game}'),
                  ),
                ),
              ],
            ),
            Text('${this.capturedPokemon} / ${widget.totalPokemon}'),
          ],
        ),
      );
    //);
  }

}