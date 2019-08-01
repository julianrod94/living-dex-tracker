import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:living_dex_tracker/data/Repository.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';
import 'package:living_dex_tracker/widgets/LivingdexElement.dart';
import 'package:living_dex_tracker/model/Livingdex.dart' as LivingdexModel;

class Livingdex extends StatelessWidget{
  final int livingdexId;

  Livingdex(@required this.livingdexId);

  Widget build(BuildContext context) =>
    FutureBuilder<LivingdexModel.Livingdex>(
      future: Repository.get().getLivingdex(livingdexId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return Text('Loading Pokemon');
          default:
            if (snapshot.hasError)
              return Text('Oops, something wrong happened. Please Reload the app.');
            else {
              LivingdexModel.Livingdex livingdex = snapshot.data;
              List<Pokemon> pokemons = livingdex.pokemons;
              var myGrid = new GridView.builder(
                itemCount: pokemons.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return new LivingdexElement(pokename: pokemons[index].name,
                      pokenumber: pokemons[index].nationalNumber,
                      pokespriteurl: pokemons[index].spriteUrl);
                },
              );
              return myGrid;
            }
        }
      },
    );
}
