import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'PokeWidget.dart';

class PokeGrid extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var pokes = [{'pokename': "Bulbasaur", 'pokespriteurl': "assets/magnemite_sprite.png", 'pokenumber': 1},{'pokename': "Ivysaur", 'pokespriteurl': "assets/magnemite_sprite.png", 'pokenumber': 2},{'pokename': "Venasaur", 'pokespriteurl': "assets/magnemite_sprite.png", 'pokenumber': 3},{'pokename': "Charmander", 'pokespriteurl': "assets/magnemite_sprite.png", 'pokenumber': 4},{'pokename': "Charmeleon", 'pokespriteurl': "assets/magnemite_sprite.png", 'pokenumber': 5},{'pokename': "Charizard", 'pokespriteurl': "assets/magnemite_sprite.png", 'pokenumber': 6},{'pokename': "Squirtle", 'pokespriteurl': "assets/magnemite_sprite.png", 'pokenumber': 7},{'pokename': "Wartortle", 'pokespriteurl': "assets/magnemite_sprite.png", 'pokenumber': 8},{'pokename': "Blastoise", 'pokespriteurl': "assets/magnemite_sprite.png", 'pokenumber': 9}];
    var myGrid = new GridView.builder(
      itemCount: pokes.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index){
        return new PokeWidget(pokename: pokes[index]['pokename'], pokenumber: pokes[index]['pokenumber'], pokespriteurl: pokes[index]['pokespriteurl']);
      },
    );
    return myGrid;
  }

}