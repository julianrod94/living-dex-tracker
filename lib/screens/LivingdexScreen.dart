import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/Livingdex.dart';

class LivingdexScreen extends StatelessWidget {
  final int livingDexId;
  final String livingdexName;

  LivingdexScreen({Key key, @required this.livingDexId, @required this.livingdexName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(livingdexName),
      ),
      body: Center(
        child: Livingdex(livingDexId),
      ),
    );
  }
}