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
      child: Center(
        child: Card(
          color: this.captured ? Colors.yellow : Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('${widget.pokename}'),
              Image.asset(widget.pokespriteurl),
              Text('# ${widget.pokenumber}'),
            ],
          ),
        ),
      ),
    );
  }
}
