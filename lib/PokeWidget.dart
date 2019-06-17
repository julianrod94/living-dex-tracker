import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PokeWidget extends StatefulWidget {

  final String pokename;
  final String pokespriteurl;
  final int pokenumber;

  PokeWidget({
    @required this.pokename,
    @required this.pokenumber,
    @required this.pokespriteurl
  });

  @override
  _PokeWidgetState createState() => _PokeWidgetState();
}

class _PokeWidgetState extends State<PokeWidget> {
  bool captured = false;

  void changeCaptureState() {
    setState(() {
      captured = !captured;
    });
  }

  Widget build(BuildContext context) {
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
                child: Text('${widget.pokename}'),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(widget.pokespriteurl),
              ),
              Text('# ${widget.pokenumber}'),
            ],
          ),
        ),
      ),
    );
  }
}
