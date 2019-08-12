import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:living_dex_tracker/data/Repository.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';
import 'package:living_dex_tracker/widgets/MiniatureBoxElement.dart';
import 'package:living_dex_tracker/widgets/LivingdexElement.dart';
import 'package:living_dex_tracker/model/Livingdex.dart' as LivingdexModel;


class Livingdex extends StatefulWidget {
  final int livingdexId;

  Livingdex(@required this.livingdexId);

  State<StatefulWidget> createState() => LivingdexState();
}

class LivingdexState extends State<Livingdex> {
  LivingdexModel.Livingdex livingdex;
  bool isLoading = true;

  initState() {
    super.initState();
    load();
  }

  load() async {
    livingdex = await Repository.get().getLivingdex(widget.livingdexId);
    this.setState(() => isLoading = false);
  }

  Widget build(BuildContext context) {
    if (this.isLoading) {
      return Text('Loading Pokemon');
    }
    else {
      List<Pokemon> pokemons = livingdex.pokemons;
      List<List<Pokemon>> grids = List.generate(pokemons.length~/30+1, (index) => pokemons.sublist(index*30,(index*30)+30>pokemons.length? pokemons.length :(index*30)+30));
      return ListView.builder(
        itemCount: pokemons.length~/30+1,
        itemBuilder: (BuildContext context,int index1){
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                    child: Text(
                        "Box ${index1}",
                        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                    )
                ),
                Card(
                  child: Container(
                    height: 290,
                    width: 50,
                    child: GridView.count(
                        physics: new NeverScrollableScrollPhysics(),
                        crossAxisCount: 6,
                        children: List.generate(grids[index1].length, (index2) {
                          return MiniatureBoxElement(
                            pokemon: grids[index1][index2],
                            isShiny: livingdex.shiny,
                            livingdexId: widget.livingdexId,
                            wasCaptured: grids[index1][index2].captured,
                          );
                        }),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}