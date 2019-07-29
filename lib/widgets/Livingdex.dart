import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:living_dex_tracker/data/Repository.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';
import 'package:living_dex_tracker/widgets/LivingdexElement.dart';

class Livingdex extends StatelessWidget{

  Widget build(BuildContext context) =>
    FutureBuilder<List<Pokemon>>(
      future: Repository.get().getAllPokemon(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return Text('Loading Pokemon');
          default:
            if (snapshot.hasError)
              return Text('Oops, something wrong happened. Please Reload the app.');
            else {
              List<Pokemon> pokes = snapshot.data;
              var myGrid = new GridView.builder(
                itemCount: pokes.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return new LivingdexElement(pokename: pokes[index].name,
                      pokenumber: pokes[index].nationalNumber,
                      pokespriteurl: pokes[index].spriteUrl);
                },
              );
              return myGrid;
            }
        }
      },
    );
}
