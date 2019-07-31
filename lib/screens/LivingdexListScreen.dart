import 'package:flutter/material.dart';
import 'LivingdexScreen.dart';
import 'CreateLivingdexScreen.dart';
import '../widgets/LivingdexListElement.dart';

class LivingdexListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            GestureDetector(
            child: LivingdexListElement(name: 'Jorge', type: 'Regional', game: 'Ruby', totalPokemon: 253),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LivingdexScreen()),
              );
            },
          ),
        ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateLivingdexScreen()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
    );
  }
}
