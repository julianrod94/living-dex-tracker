import 'package:flutter/material.dart';
import 'PokeGridView.dart';
import 'AddView.dart';
import 'PokedexWidget.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: RaisedButton(
            child: PokedexWidget(pokedexname: 'Jorge', pokedexgame: 'Ruby', pokedexspriteurl: "assets/magnemite_sprite.png"),
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PokeGridView()),
                );
              },
      ),
        ),
          floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddView()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),

    );
  }
}


/*
child: RaisedButton(
child: PokedexWidget(pokedexname: 'Jorge', pokedexgame: 'Ruby', pokedexspriteurl: "assets/magnemite_sprite.png"),
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => GridView()),
);
},*/
